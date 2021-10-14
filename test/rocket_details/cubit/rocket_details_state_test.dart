// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_demo/rocket_details/rocket_details.dart';

void main() {
  group('RocketDetailsState', () {
    const rocket = Rocket(
      id: '0',
      name: 'mock-rocket-name',
      description: 'mock-rocket-description',
      height: Length(meters: 1, feet: 1),
      diameter: Length(meters: 1, feet: 1),
      mass: Mass(kg: 1, lb: 1),
    );

    test('supports value comparison', () {
      expect(
        RocketDetailsState(rocket: rocket),
        RocketDetailsState(rocket: rocket),
      );
    });
  });
}
