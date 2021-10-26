// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:spacex_demo/rockets/rockets.dart';

void main() {
  group('RocketsState', () {
    test('supports value comparison', () {
      expect(
        RocketsState(
          status: RocketsStatus.success,
          rockets: const [],
        ),
        RocketsState(
          status: RocketsStatus.success,
          rockets: const [],
        ),
      );
    });
  });
}
