import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_demo/app/app.dart';
import 'package:spacex_demo/home/home.dart';

import '../helpers/helpers.dart';

class MockRocketRepository extends Mock implements RocketRepository {}

void main() {
  late RocketRepository rocketRepository;

  final rockets = List.generate(
    3,
    (i) => Rocket(
      id: '$i',
      name: 'mock-rocket-name-$i',
      description: 'mock-rocket-description-$i',
      height: const Length(meters: 1, feet: 1),
      diameter: const Length(meters: 1, feet: 1),
      mass: const Mass(kg: 1, lb: 1),
    ),
  );

  setUp(() {
    rocketRepository = MockRocketRepository();
    when(() => rocketRepository.fetchAllRockets())
        .thenAnswer((_) async => rockets);
  });

  group('App', () {
    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(
        App(
          rocketRepository: rocketRepository,
        ),
      );
      expect(find.byType(AppView), findsOneWidget);
    });
  });

  group('AppView', () {
    testWidgets('renders HomePage', (tester) async {
      await tester.pumpApp(
        const AppView(),
        rocketRepository: rocketRepository,
      );

      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
