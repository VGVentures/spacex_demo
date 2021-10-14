import 'package:crew_member_repository/crew_member_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex_demo/app/app.dart';
import 'package:spacex_demo/home/home.dart';

import '../helpers/helpers.dart';

class MockRocketRepository extends Mock implements RocketRepository {}

class MockCrewMemberRepository extends Mock implements CrewMemberRepository {}

void main() {
  late RocketRepository rocketRepository;
  late CrewMemberRepository crewMemberRepository;

  setUp(() {
    rocketRepository = MockRocketRepository();
    crewMemberRepository = MockCrewMemberRepository();
  });

  group('App', () {
    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(
        App(
          rocketRepository: rocketRepository,
          crewMemberRepository: crewMemberRepository,
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
