import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_navigator/mock_navigator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_demo/rockets/rockets.dart';

import '../../helpers/helpers.dart';

class MockRocketRepository extends Mock implements RocketRepository {}

class MockRocketsCubit extends MockCubit<RocketsState> implements RocketsCubit {
}

class MockNavigator extends Mock
    with MockNavigatorDiagnosticsMixin
    implements MockNavigatorBase {}

class FakeRoute<T> extends Fake implements Route<T> {}

void main() {
  final rockets = List.generate(
    3,
    (i) => Rocket(
      id: '$i',
      name: 'mock-rocket-name-$i',
      description: 'mock-rocket-description-$i',
      height: const Length(meters: 1.0, feet: 1.0),
      diameter: const Length(meters: 1.0, feet: 1.0),
      mass: const Mass(kg: 1.0, lb: 1.0),
    ),
  );

  group('RocketsPage', () {
    late RocketRepository rocketRepository;

    setUp(() {
      rocketRepository = MockRocketRepository();
      when(() => rocketRepository.fetchAllRockets())
          .thenAnswer((_) async => rockets);
    });

    testWidgets('renders RocketsView', (tester) async {
      await tester.pumpApp(
        const RocketsPage(),
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
      when(() => navigator.push(any())).thenAnswer((_) async => null);
    });

    setUpAll(() {
      registerFallbackValue<RocketsState>(const RocketsState());
      registerFallbackValue<Route<Object?>>(FakeRoute<Object?>());
    });

    testWidgets('renders empty page when status is initial', (tester) async {
      const key = Key('rocketsView_initial_sizedBox');

      when(() => rocketsCubit.state).thenReturn(
        const RocketsState(
          status: RocketsStatus.initial,
        ),
      );

      await tester.pumpApp(
        BlocProvider.value(
          value: rocketsCubit,
          child: RocketsView(),
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
            child: RocketsView(),
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
            child: RocketsView(),
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
            child: RocketsView(),
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
            child: MockNavigatorProvider(
              navigator: navigator,
              child: RocketsView(),
            ),
          ),
        );

        await tester.tap(find.text(rockets.first.name));
        verify(() => navigator.push(any())).called(1);
      },
    );
  });
}
