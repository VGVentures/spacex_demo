import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_demo/home/home.dart';

import '../../helpers/helpers.dart';

class MockRocketRepository extends Mock implements RocketRepository {}

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

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

  group('HomePage', () {
    late RocketRepository rocketRepository;

    setUp(() {
      rocketRepository = MockRocketRepository();
      when(() => rocketRepository.fetchAllRockets())
          .thenAnswer((_) async => rockets);
    });

    testWidgets('renders HomeView', (tester) async {
      await tester.pumpApp(
        const HomePage(),
        rocketRepository: rocketRepository,
      );
      expect(find.byType(HomeView), findsOneWidget);
    });
  });

  group('HomeView', () {
    late HomeCubit homeCubit;

    setUp(() {
      homeCubit = MockHomeCubit();
    });

    setUpAll(() {
      registerFallbackValue<HomeState>(const HomeState());
    });

    testWidgets('renders empty page when status is initial', (tester) async {
      const key = Key('homeView_initial_sizedBox');

      when(() => homeCubit.state).thenReturn(
        const HomeState(
          status: HomeStatus.initial,
        ),
      );

      await tester.pumpApp(
        BlocProvider.value(
          value: homeCubit,
          child: HomeView(),
        ),
      );

      expect(find.byKey(key), findsOneWidget);
    });

    testWidgets(
      'renders loading indicator when status is loading',
      (tester) async {
        const key = Key('homeView_loading_indicator');

        when(() => homeCubit.state).thenReturn(
          const HomeState(
            status: HomeStatus.loading,
          ),
        );

        await tester.pumpApp(
          BlocProvider.value(
            value: homeCubit,
            child: HomeView(),
          ),
        );

        expect(find.byKey(key), findsOneWidget);
      },
    );

    testWidgets(
      'renders error text when status is failure',
      (tester) async {
        const key = Key('homeView_failure_text');

        when(() => homeCubit.state).thenReturn(
          const HomeState(
            status: HomeStatus.failure,
          ),
        );

        await tester.pumpApp(
          BlocProvider.value(
            value: homeCubit,
            child: HomeView(),
          ),
        );

        expect(find.byKey(key), findsOneWidget);
      },
    );

    testWidgets(
      'renders list of rockets when status is success',
      (tester) async {
        const key = Key('homeView_success_rocketList');

        when(() => homeCubit.state).thenReturn(
          HomeState(
            status: HomeStatus.success,
            rockets: rockets,
          ),
        );

        await tester.pumpApp(
          BlocProvider.value(
            value: homeCubit,
            child: HomeView(),
          ),
        );

        expect(find.byKey(key), findsOneWidget);
        expect(find.byType(ListTile), findsNWidgets(rockets.length));
      },
    );
  });
}
