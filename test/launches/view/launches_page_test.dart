// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_demo/launches/launches.dart';

import '../../helpers/helpers.dart';

class MockLaunchRepository extends Mock implements LaunchRepository {}

class MockLaunchesCubit extends MockCubit<LaunchesState>
    implements LaunchesCubit {}

void main() {
  final latestLaunch = Launch(
    id: '0',
    name: 'mock-launch-name',
    links: const Links(
      patch: Patch(
        small: 'https://avatars.githubusercontent.com/u/2918581?v=4',
        large: 'https://avatars.githubusercontent.com/u/2918581?v=4',
      ),
      webcast: 'https://www.youtube.com',
      wikipedia: 'https://www.wikipedia.org/',
    ),
  );

  group('LaunchesPage', () {
    late LaunchRepository launchRepository;

    setUp(() {
      launchRepository = MockLaunchRepository();
      when(
        () => launchRepository.fetchLatestLaunch(),
      ).thenAnswer((_) async => latestLaunch);
    });

    test('has route', () {
      expect(
        LaunchesPage.route(),
        isA<MaterialPageRoute<void>>(),
      );
    });

    testWidgets('renders LaunchesView', (tester) async {
      await tester.pumpApp(
        Navigator(
          onGenerateRoute: (_) => LaunchesPage.route(),
        ),
        launchRepository: launchRepository,
      );

      expect(find.byType(LaunchesPage), findsOneWidget);
    });
  });

  group('LaunchesView', () {
    late LaunchesCubit launchesCubit;
    late MockNavigator navigator;

    setUp(() {
      launchesCubit = MockLaunchesCubit();
      navigator = MockNavigator();

      when(() => navigator.push(any(that: isRoute<void>())))
          .thenAnswer((_) async {});
    });

    setUpAll(() {
      registerFallbackValue<LaunchesState>(const LaunchesState());
      registerFallbackValue<Uri>(Uri());
    });

    testWidgets('renders empty page when status is initial', (tester) async {
      const key = Key('launchesView_initial_sizedBox');

      when(() => launchesCubit.state).thenReturn(
        const LaunchesState(),
      );

      await tester.pumpApp(
        BlocProvider.value(
          value: launchesCubit,
          child: const LaunchesView(),
        ),
      );

      expect(find.byKey(key), findsOneWidget);
    });

    testWidgets(
      'renders loading indicator when status is loading',
      (tester) async {
        const key = Key('launchesView_loading_indicator');

        when(() => launchesCubit.state).thenReturn(
          const LaunchesState(
            status: LaunchesStatus.loading,
          ),
        );

        await tester.pumpApp(
          BlocProvider.value(
            value: launchesCubit,
            child: const LaunchesView(),
          ),
        );

        expect(find.byKey(key), findsOneWidget);
      },
    );

    testWidgets(
      'renders error text when status is failure',
      (tester) async {
        const key = Key('launchesView_failure_text');

        when(() => launchesCubit.state).thenReturn(
          const LaunchesState(
            status: LaunchesStatus.failure,
          ),
        );

        await tester.pumpApp(
          BlocProvider.value(
            value: launchesCubit,
            child: const LaunchesView(),
          ),
        );

        expect(find.byKey(key), findsOneWidget);
      },
    );

    testWidgets(
      'renders the latest launch when status is success',
      (tester) async {
        const key = Key('launchesView_success_latestLaunch');

        when(() => launchesCubit.state).thenReturn(
          LaunchesState(
            status: LaunchesStatus.success,
            latestLaunch: latestLaunch,
          ),
        );

        await mockNetworkImages(() async {
          await tester.pumpApp(
            BlocProvider.value(
              value: launchesCubit,
              child: const LaunchesView(),
            ),
          );
        });

        expect(find.byKey(key), findsOneWidget);
      },
    );
  });
}
