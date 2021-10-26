import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_demo/crew_member_details/crew_member_details.dart';
import 'package:spacex_demo/crew_member_details/cubit/crew_member_details_cubit.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import '../../helpers/helpers.dart';

class MockCrewMemberDetailsCubit extends MockCubit<CrewMemberDetailsState>
    implements CrewMemberDetailsCubit {}

class MockUrlLauncherPlatorm extends Mock
    with MockPlatformInterfaceMixin
    implements UrlLauncherPlatform {}

void main() {
  late CrewMemberDetailsCubit crewMemberDetailsCubit;
  late UrlLauncherPlatform urlLauncherPlatform;

  const crewMember = CrewMember(
    id: '0',
    name: 'Alejandro Ferrero',
    status: 'active',
    agency: 'Very Good Aliens',
    image:
        'https://media-exp1.licdn.com/dms/image/C4D03AQHVNIVOMkwQaA/profile-displayphoto-shrink_200_200/0/1631637257882?e=1637193600&v=beta&t=jFm-Ckb0KS0Z5hJDbo3ZBSEZSYLHfllUf4N-IV2NDTc',
    wikipedia: 'https://www.wikipedia.org/',
    launches: ['Launch 1'],
  );

  setUp(() {
    crewMemberDetailsCubit = MockCrewMemberDetailsCubit();
    when(() => crewMemberDetailsCubit.state)
        .thenReturn(const CrewMemberDetailsState(crewMember: crewMember));

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
    registerFallbackValue<CrewMemberDetailsState>(
      const CrewMemberDetailsState(crewMember: crewMember),
    );
  });

  group('CrewMemberDetailsPage', () {
    test(
      'has route',
      () {
        expect(
          CrewMemberDetailsPage.route(crewMember: crewMember),
          isA<MaterialPageRoute<void>>(),
        );
      },
    );

    testWidgets('renders CrewMemberDetailsView on route', (tester) async {
      await mockNetworkImages(() async {
        await tester.pumpApp(
          Navigator(
            onGenerateRoute: (_) =>
                CrewMemberDetailsPage.route(crewMember: crewMember),
          ),
        );
        expect(find.byType(CrewMemberDetailsView), findsOneWidget);
      });
    });
  });

  group('CrewMemberDetailsView', () {
    testWidgets('renders crew member image', (tester) async {
      const key = Key('crewMemberDetailsPage_imageHeader');

      await mockNetworkImages(() async {
        await tester.pumpApp(
          BlocProvider.value(
            value: crewMemberDetailsCubit,
            child: const CrewMemberDetailsView(),
          ),
        );
      });

      expect(find.byKey(key), findsOneWidget);
    });

    group('title header', () {
      testWidgets(
        'renders check icon when crew member is active',
        (tester) async {
          await mockNetworkImages(() async {
            await tester.pumpApp(
              BlocProvider.value(
                value: crewMemberDetailsCubit,
                child: const CrewMemberDetailsView(),
              ),
            );
          });

          expect(find.byIcon(Icons.check), findsOneWidget);
        },
      );

      testWidgets(
        'renders cross icon when crew member is inactive',
        (tester) async {
          when(() => crewMemberDetailsCubit.state).thenReturn(
            const CrewMemberDetailsState(
              crewMember: CrewMember(
                id: '0',
                name: 'Alejandro Ferrero',
                status: 'inactive',
                agency: 'Very Good Aliens',
                image:
                    'https://media-exp1.licdn.com/dms/image/C4D03AQHVNIVOMkwQaA/profile-displayphoto-shrink_200_200/0/1631637257882?e=1637193600&v=beta&t=jFm-Ckb0KS0Z5hJDbo3ZBSEZSYLHfllUf4N-IV2NDTc',
                wikipedia: 'https://www.wikipedia.org/',
                launches: ['Launch 1'],
              ),
            ),
          );

          await mockNetworkImages(() async {
            await tester.pumpApp(
              BlocProvider.value(
                value: crewMemberDetailsCubit,
                child: const CrewMemberDetailsView(),
              ),
            );
          });

          expect(find.byIcon(Icons.close), findsOneWidget);
        },
      );

      testWidgets('renders agency subtitle', (tester) async {
        const agencyKey =
            Key('crewMemberDetailsPage_titleHeader_agencyRichText');

        await mockNetworkImages(() async {
          await tester.pumpApp(
            BlocProvider.value(
              value: crewMemberDetailsCubit,
              child: const CrewMemberDetailsView(),
            ),
          );
        });

        expect(
          find.byWidgetPredicate(
            (Widget widget) =>
                widget is RichText &&
                widget.key == agencyKey &&
                widget.text.toPlainText() == 'Agency: ${crewMember.agency}',
          ),
          findsOneWidget,
        );
      });

      testWidgets('renders launch subtitle', (tester) async {
        const launchKey =
            Key('crewMemberDetailsPage_titleHeader_launchRichText');

        await mockNetworkImages(() async {
          await tester.pumpApp(
            BlocProvider.value(
              value: crewMemberDetailsCubit,
              child: const CrewMemberDetailsView(),
            ),
          );
        });

        expect(
          find.byWidgetPredicate(
            (Widget widget) =>
                widget is RichText &&
                widget.key == launchKey &&
                widget.text.toPlainText() ==
                    'Has participated in ${crewMember.launches.length} launch',
          ),
          findsOneWidget,
        );
      });
    });
    group('open wikipedia button', () {
      const key = Key('crewMemberDetailsPage_openWikipedia_elevatedButton');

      testWidgets(
        'is rendered',
        (tester) async {
          await mockNetworkImages(() async {
            await tester.pumpApp(
              BlocProvider.value(
                value: crewMemberDetailsCubit,
                child: const CrewMemberDetailsView(),
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
                value: crewMemberDetailsCubit,
                child: const CrewMemberDetailsView(),
              ),
            );
          });

          await tester.tap(find.byKey(key));

          verify(() => urlLauncherPlatform.canLaunch(crewMember.wikipedia))
              .called(1);
          verify(
            () => urlLauncherPlatform.launch(
              crewMember.wikipedia,
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
