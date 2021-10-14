// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:spacex_demo/home/home.dart';

void main() {
  group('HomeState', () {
    test('supports value comparison', () {
      expect(
        HomeState(
          status: HomeStatus.success,
          rockets: const [],
        ),
        HomeState(
          status: HomeStatus.success,
          rockets: const [],
        ),
      );
    });
  });
}
