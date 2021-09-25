// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_demo/rocket_details/rocket_details.dart';

class MockRocketRepository extends Mock implements RocketRepository {}

void main() {
  group('RocketDetailsCubit', () {
    const rocket = Rocket(
      id: '0',
      name: 'mock-rocket-name',
      description: 'mock-rocket-description',
      height: Length(meters: 1.0, feet: 1.0),
      diameter: Length(meters: 1.0, feet: 1.0),
      mass: Mass(kg: 1.0, lb: 1.0),
    );

    test('initial state is correct', () {
      expect(
        RocketDetailsCubit(rocket: rocket).state,
        equals(RocketDetailsState(rocket: rocket)),
      );
    });
  });
}
