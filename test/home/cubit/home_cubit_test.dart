// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_demo/home/home.dart';

class MockRocketRepository extends Mock implements RocketRepository {}

void main() {
  group('HomeCubit', () {
    late RocketRepository rocketRepository;

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

    setUp(() {
      rocketRepository = MockRocketRepository();
      when(() => rocketRepository.fetchAllRockets())
          .thenAnswer((_) async => rockets);
    });

    test('initial state is correct', () {
      expect(
        HomeCubit(
          rocketRepository: rocketRepository,
        ).state,
        equals(HomeState(
          status: HomeStatus.initial,
        )),
      );
    });

    group('.fetchAllRockets', () {
      blocTest<HomeCubit, HomeState>(
        'emits state with updated rockets',
        build: () => HomeCubit(
          rocketRepository: rocketRepository,
        ),
        act: (cubit) => cubit.fetchAllRockets(),
        expect: () => [
          HomeState(
            status: HomeStatus.loading,
          ),
          HomeState(
            status: HomeStatus.success,
            rockets: rockets,
          ),
        ],
      );

      blocTest<HomeCubit, HomeState>(
        'emits failure state when repository throws exception',
        build: () {
          when(() => rocketRepository.fetchAllRockets()).thenThrow(Exception());

          return HomeCubit(
            rocketRepository: rocketRepository,
          );
        },
        act: (cubit) => cubit.fetchAllRockets(),
        expect: () => [
          HomeState(
            status: HomeStatus.loading,
          ),
          HomeState(
            status: HomeStatus.failure,
          ),
        ],
      );
    });
  });
}
