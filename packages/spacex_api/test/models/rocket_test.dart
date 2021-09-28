// ignore_for_file: prefer_const_constructors
import 'package:spacex_api/spacex_api.dart';
import 'package:test/test.dart';

void main() {
  group('Rocket', () {
    test('supports value comparisons', () {
      expect(
        Rocket(
          id: '1',
          name: 'mock-rocket-name-1',
          description: 'mock-rocket-description-1',
          height: const Length(meters: 1, feet: 1),
          diameter: const Length(meters: 1, feet: 1),
          mass: const Mass(kg: 1, lb: 1),
        ),
        Rocket(
          id: '1',
          name: 'mock-rocket-name-1',
          description: 'mock-rocket-description-1',
          height: const Length(meters: 1, feet: 1),
          diameter: const Length(meters: 1, feet: 1),
          mass: const Mass(kg: 1, lb: 1),
        ),
      );
    });

    test('has concise toString', () {
      expect(
        Rocket(
          id: '1',
          name: 'mock-rocket-name-1',
          description: 'mock-rocket-description-1',
          height: const Length(meters: 1, feet: 1),
          diameter: const Length(meters: 1, feet: 1),
          mass: const Mass(kg: 1, lb: 1),
        ).toString(),
        equals('Rocket(1, mock-rocket-name-1)'),
      );
    });
  });

  group('Length', () {
    test('supports value comparisons', () {
      expect(
        Length(meters: 1, feet: 1),
        Length(meters: 1, feet: 1),
      );
    });

    test('has concise toString', () {
      expect(
        Length(meters: 1, feet: 1).toString(),
        equals('Length(1 m, 1 ft)'),
      );
    });
  });

  group('Mass', () {
    test('supports value comparisons', () {
      expect(
        Mass(kg: 1, lb: 1),
        Mass(kg: 1, lb: 1),
      );
    });

    test('has concise toString', () {
      expect(
        Mass(kg: 1, lb: 1).toString(),
        equals('Mass(1 kg, 1 lb)'),
      );
    });
  });
}
