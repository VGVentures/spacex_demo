// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_demo/rockets/rockets.dart';

class MockRocketRepository extends Mock implements RocketRepository {}

void main() {
  group('RocketsCubit', () {
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
        RocketsCubit(
          rocketRepository: rocketRepository,
        ).state,
        equals(RocketsState(
          status: RocketsStatus.initial,
        )),
      );
    });

    group('.fetchAllRockets', () {
      blocTest<RocketsCubit, RocketsState>(
        'emits state with updated rockets',
        build: () => RocketsCubit(
          rocketRepository: rocketRepository,
        ),
        act: (cubit) => cubit.fetchAllRockets(),
        expect: () => [
          RocketsState(
            status: RocketsStatus.loading,
          ),
          RocketsState(
            status: RocketsStatus.success,
            rockets: rockets,
          ),
        ],
      );

      blocTest<RocketsCubit, RocketsState>(
        'emits failure state when repository throws exception',
        build: () {
          when(() => rocketRepository.fetchAllRockets()).thenThrow(Exception());

          return RocketsCubit(
            rocketRepository: rocketRepository,
          );
        },
        act: (cubit) => cubit.fetchAllRockets(),
        expect: () => [
          RocketsState(
            status: RocketsStatus.loading,
          ),
          RocketsState(
            status: RocketsStatus.failure,
          ),
        ],
      );
    });
  });
}
