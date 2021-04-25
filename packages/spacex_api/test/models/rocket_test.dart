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
          height: const Length(meters: 1.0, feet: 1.0),
          diameter: const Length(meters: 1.0, feet: 1.0),
          mass: const Mass(kg: 1.0, lb: 1.0),
        ),
        Rocket(
          id: '1',
          name: 'mock-rocket-name-1',
          description: 'mock-rocket-description-1',
          height: const Length(meters: 1.0, feet: 1.0),
          diameter: const Length(meters: 1.0, feet: 1.0),
          mass: const Mass(kg: 1.0, lb: 1.0),
        ),
      );
    });

    test('has concise toString', () {
      expect(
        Rocket(
          id: '1',
          name: 'mock-rocket-name-1',
          description: 'mock-rocket-description-1',
          height: const Length(meters: 1.0, feet: 1.0),
          diameter: const Length(meters: 1.0, feet: 1.0),
          mass: const Mass(kg: 1.0, lb: 1.0),
        ).toString(),
        equals('Rocket(1, mock-rocket-name-1)'),
      );
    });
  });

  group('Length', () {
    test('supports value comparisons', () {
      expect(
        Length(meters: 1.0, feet: 1.0),
        Length(meters: 1.0, feet: 1.0),
      );
    });

    test('has concise toString', () {
      expect(
        Length(meters: 1.0, feet: 1.0).toString(),
        equals('Length(1.0 m, 1.0 ft)'),
      );
    });
  });

  group('Mass', () {
    test('supports value comparisons', () {
      expect(
        Mass(kg: 1.0, lb: 1.0),
        Mass(kg: 1.0, lb: 1.0),
      );
    });

    test('has concise toString', () {
      expect(
        Mass(kg: 1.0, lb: 1.0).toString(),
        equals('Mass(1.0 kg, 1.0 lb)'),
      );
    });
  });
}
