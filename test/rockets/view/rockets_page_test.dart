import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_demo/rockets/rockets.dart';

import '../../helpers/helpers.dart';

class MockRocketRepository extends Mock implements RocketRepository {}

class MockRocketsCubit extends MockCubit<RocketsState>
    implements RocketsCubit {}

void main() {
  final rockets = List.generate(
    3,
    (i) => Rocket(
      id: '$i',
      name: 'mock-rocket-name-$i',
      description: 'mock-rocket-description-$i',
      height: const Length(meters: 1, feet: 1),
      diameter: const Length(meters: 1, feet: 1),
      mass: const Mass(kg: 1, lb: 1),
    ),
  );

  group('RocketsPage', () {
    late RocketRepository rocketRepository;

    setUp(() {
      rocketRepository = MockRocketRepository();
      when(() => rocketRepository.fetchAllRockets())
          .thenAnswer((_) async => rockets);
    });

    test(
      'has route',
      () => expect(
        RocketsPage.route(),
        isA<MaterialPageRoute<void>>(),
      ),
    );

    testWidgets('renders RocketView', (tester) async {
      await tester.pumpApp(
        Navigator(
          onGenerateRoute: (_) => RocketsPage.route(),
        ),
        rocketRepository: rocketRepository,
      );
      expect(find.byType(RocketsView), findsOneWidget);
    });
  });

  group('RocketsView', () {
    late RocketsCubit rocketsCubit;
    late MockNavigator navigator;

    setUp(() {
      rocketsCubit = MockRocketsCubit();

      navigator = MockNavigator();
      when(() => navigator.push<void>(any(that: isRoute<void>())))
          .thenAnswer((_) async {});
    });

    setUpAll(() {
      registerFallbackValue(const RocketsState());
    });

    testWidgets('renders empty page when status is initial', (tester) async {
      const key = Key('rocketsView_initial_sizedBox');

      when(() => rocketsCubit.state).thenReturn(
        const RocketsState(),
      );

      await tester.pumpApp(
        BlocProvider.value(
          value: rocketsCubit,
          child: const RocketsView(),
        ),
      );

      expect(find.byKey(key), findsOneWidget);
    });

    testWidgets(
      'renders loading indicator when status is loading',
      (tester) async {
        const key = Key('rocketsView_loading_indicator');

        when(() => rocketsCubit.state).thenReturn(
          const RocketsState(
            status: RocketsStatus.loading,
          ),
        );

        await tester.pumpApp(
          BlocProvider.value(
            value: rocketsCubit,
            child: const RocketsView(),
          ),
        );

        expect(find.byKey(key), findsOneWidget);
      },
    );

    testWidgets(
      'renders error text when status is failure',
      (tester) async {
        const key = Key('rocketsView_failure_text');

        when(() => rocketsCubit.state).thenReturn(
          const RocketsState(
            status: RocketsStatus.failure,
          ),
        );

        await tester.pumpApp(
          BlocProvider.value(
            value: rocketsCubit,
            child: const RocketsView(),
          ),
        );

        expect(find.byKey(key), findsOneWidget);
      },
    );

    testWidgets(
      'renders list of rockets when status is success',
      (tester) async {
        const key = Key('rocketsView_success_rocketList');

        when(() => rocketsCubit.state).thenReturn(
          RocketsState(
            status: RocketsStatus.success,
            rockets: rockets,
          ),
        );

        await tester.pumpApp(
          BlocProvider.value(
            value: rocketsCubit,
            child: const RocketsView(),
          ),
        );

        expect(find.byKey(key), findsOneWidget);
        expect(find.byType(ListTile), findsNWidgets(rockets.length));
      },
    );

    testWidgets(
      'navigates to RocketDetailsPage when rocket is tapped',
      (tester) async {
        when(() => rocketsCubit.state).thenReturn(
          RocketsState(
            status: RocketsStatus.success,
            rockets: rockets,
          ),
        );

        await tester.pumpApp(
          BlocProvider.value(
            value: rocketsCubit,
            child: const RocketsView(),
          ),
          navigator: navigator,
        );

        await tester.tap(find.text(rockets.first.name));

        verify(() => navigator.push<void>(any(that: isRoute<void>())))
            .called(1);
      },
    );
  });
}
