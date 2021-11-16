// ignore_for_file: prefer_const_constructors
import 'package:launch_repository/launch_repository.dart';
import 'package:test/test.dart';

void main() {
  group('LaunchesRepository', () {
    test('can be instantiated', () {
      expect(LaunchRepository(), isNotNull);
    });
  });
}
