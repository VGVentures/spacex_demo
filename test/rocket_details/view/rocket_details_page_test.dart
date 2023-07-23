import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_demo/rocket_details/rocket_details.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import '../../helpers/helpers.dart';

class MockRocketDetailsCubit extends MockCubit<RocketDetailsState>
    implements RocketDetailsCubit {}

class MockUrlLauncherPlatorm extends Mock
    with MockPlatformInterfaceMixin
    implements UrlLauncherPlatform {}

void main() {
  late RocketDetailsCubit rocketDetailsCubit;
  late UrlLauncherPlatform urlLauncherPlatform;

  final rocket = Rocket(
    id: '0',
    name: 'mock-rocket-name',
    description: 'mock-rocket-description',
    height: const Length(meters: 1, feet: 1),
    diameter: const Length(meters: 1, feet: 1),
    mass: const Mass(kg: 1, lb: 1),
    flickrImages: const ['https://example.com/'],
    active: true,
    firstFlight: DateTime(2021, 12, 31),
    wikipedia: 'https://wikipedia.com/',
  );

  setUp(() {
    rocketDetailsCubit = MockRocketDetailsCubit();
    when(() => rocketDetailsCubit.state).thenReturn(
      RocketDetailsState(rocket: rocket),
    );

    urlLauncherPlatform = MockUrlLauncherPlatorm();
    UrlLauncherPlatform.instance = urlLauncherPlatform;
    when(() => urlLauncherPlatform.canLaunch(any()))
        .thenAnswer((_) async => true);
    when(
      () => urlLauncherPlatform.launch(
        any(),
        useSafariVC: any(named: 'useSafariVC'),
        useWebView: any(named: 'useWebView'),
        enableJavaScript: any(named: 'enableJavaScript'),
        enableDomStorage: any(named: 'enableDomStorage'),
        universalLinksOnly: any(named: 'universalLinksOnly'),
        headers: any(named: 'headers'),
        webOnlyWindowName: any(named: 'webOnlyWindowName'),
      ),
    ).thenAnswer((_) async => true);
  });

  setUpAll(() {
    registerFallbackValue(RocketDetailsState(rocket: rocket));
  });

  group('RocketDetailsPage', () {
    test('has route', () {
      expect(
        RocketDetailsPage.route(rocket: rocket),
        isA<MaterialPageRoute<void>>(),
      );
    });

    testWidgets('renders RocketDetailsView', (tester) async {
      await mockNetworkImages(() async {
        await tester.pumpApp(
          Navigator(
            onGenerateRoute: (_) => RocketDetailsPage.route(rocket: rocket),
          ),
        );
        expect(find.byType(RocketDetailsView), findsOneWidget);
      });
    });
  });

  group('RocketDetailsView', () {
    testWidgets('renders first flickr image if present', (tester) async {
      const key = Key('rocketDetailsPage_imageHeader');

      await mockNetworkImages(() async {
        await tester.pumpApp(
          BlocProvider.value(
            value: rocketDetailsCubit,
            child: const RocketDetailsView(),
          ),
        );
      });

      expect(find.byKey(key), findsOneWidget);
    });

    group('title header', () {
      testWidgets('renders rocket name', (tester) async {
        const key = Key('rocketDetailsPage_titleHeader');

        await mockNetworkImages(() async {
          await tester.pumpApp(
            BlocProvider.value(
              value: rocketDetailsCubit,
              child: const RocketDetailsView(),
            ),
          );
        });

        expect(find.byKey(key), findsOneWidget);
        expect(
          find.descendant(
            of: find.byKey(key),
            matching: find.text(rocket.name),
          ),
          findsOneWidget,
        );
      });

      testWidgets('renders check icon when rocket is active', (tester) async {
        await mockNetworkImages(() async {
          await tester.pumpApp(
            BlocProvider.value(
              value: rocketDetailsCubit,
              child: const RocketDetailsView(),
            ),
          );
        });

        expect(find.byIcon(Icons.check), findsOneWidget);
      });

      testWidgets('renders cross icon when rocket is inactive', (tester) async {
        when(() => rocketDetailsCubit.state).thenReturn(
          const RocketDetailsState(
            rocket: Rocket(
              id: '0',
              name: 'mock-rocket-name',
              description: 'mock-rocket-description',
              height: Length(meters: 1, feet: 1),
              diameter: Length(meters: 1, feet: 1),
              mass: Mass(kg: 1, lb: 1),
              active: false,
            ),
          ),
        );

        await mockNetworkImages(() async {
          await tester.pumpApp(
            BlocProvider.value(
              value: rocketDetailsCubit,
              child: const RocketDetailsView(),
            ),
          );
        });

        expect(find.byIcon(Icons.close), findsOneWidget);
      });

      testWidgets(
        'renders first launch date',
        (tester) async {
          await mockNetworkImages(() async {
            await tester.pumpApp(
              BlocProvider.value(
                value: rocketDetailsCubit,
                child: const RocketDetailsView(),
              ),
            );
          });

          expect(find.text('First launch: 31-12-2021'), findsOneWidget);
        },
      );
    });

    testWidgets('renders description', (tester) async {
      await mockNetworkImages(() async {
        await tester.pumpApp(
          BlocProvider.value(
            value: rocketDetailsCubit,
            child: const RocketDetailsView(),
          ),
        );
      });

      expect(find.text(rocket.description), findsOneWidget);
    });

    group('open wikipedia button', () {
      const key = Key('rocketDetailsPage_openWikipedia_elevatedButton');

      testWidgets(
        'is not rendered when the rocket does not contain a wikipedia url',
        (tester) async {
          when(() => rocketDetailsCubit.state).thenReturn(
            const RocketDetailsState(
              rocket: Rocket(
                id: '0',
                name: 'mock-rocket-name',
                description: 'mock-rocket-description',
                height: Length(meters: 1, feet: 1),
                diameter: Length(meters: 1, feet: 1),
                mass: Mass(kg: 1, lb: 1),
              ),
            ),
          );

          await mockNetworkImages(() async {
            await tester.pumpApp(
              BlocProvider.value(
                value: rocketDetailsCubit,
                child: const RocketDetailsView(),
              ),
            );
          });

          expect(find.byKey(key), findsNothing);
        },
      );

      testWidgets(
        'is rendered when the rocket contains a wikipedia url',
        (tester) async {
          await mockNetworkImages(() async {
            await tester.pumpApp(
              BlocProvider.value(
                value: rocketDetailsCubit,
                child: const RocketDetailsView(),
              ),
            );
          });

          expect(find.byKey(key), findsOneWidget);
        },
      );

      testWidgets(
        'attempts to open wikipedia url when pressed',
        (tester) async {
          await mockNetworkImages(() async {
            await tester.pumpApp(
              BlocProvider.value(
                value: rocketDetailsCubit,
                child: const RocketDetailsView(),
              ),
            );
          });

          await tester.tap(find.byKey(key));

          verify(() => urlLauncherPlatform.canLaunch(rocket.wikipedia!))
              .called(1);
          verify(
            () => urlLauncherPlatform.launch(
              rocket.wikipedia!,
              useSafariVC: true,
              useWebView: false,
              enableJavaScript: false,
              enableDomStorage: false,
              universalLinksOnly: false,
              headers: const <String, String>{},
            ),
          ).called(1);
        },
      );
    });
  });
}
