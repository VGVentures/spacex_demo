// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_demo/launches/launches.dart';

class MockLaunchRepository extends Mock implements LaunchRepository {}

void main() {
  group('CrewCubit', () {
    late LaunchRepository launchRepository;

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

    setUp(() {
      launchRepository = MockLaunchRepository();
      when(() => launchRepository.fetchLatestLaunch())
          .thenAnswer((_) async => latestLaunch);
    });

    test(
      'initial state is correct',
      () => {
        expect(
          LaunchesCubit(launchRepository: launchRepository).state,
          equals(const LaunchesState()),
        )
      },
    );

    blocTest<LaunchesCubit, LaunchesState>(
      'emits state with updated launch',
      build: () => LaunchesCubit(launchRepository: launchRepository),
      act: (cubit) => cubit.fetchLatestLaunch(),
      expect: () => [
        const LaunchesState(status: LaunchesStatus.loading),
        LaunchesState(
          status: LaunchesStatus.success,
          latestLaunch: latestLaunch,
        ),
      ],
    );

    blocTest<LaunchesCubit, LaunchesState>(
      'emits failure state when repository throws exception',
      setUp: () {
        when(() => launchRepository.fetchLatestLaunch()).thenThrow(Exception());
      },
      build: () => LaunchesCubit(launchRepository: launchRepository),
      act: (cubit) => cubit.fetchLatestLaunch(),
      expect: () => [
        const LaunchesState(status: LaunchesStatus.loading),
        const LaunchesState(status: LaunchesStatus.failure),
      ],
    );
  });
}
