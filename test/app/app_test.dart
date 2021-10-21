import 'package:crew_member_repository/crew_member_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_demo/app/app.dart';
import 'package:spacex_demo/home/home.dart';

import '../helpers/helpers.dart';

class MockRocketRepository extends Mock implements RocketRepository {}

class MockCrewMemberRepository extends Mock implements CrewMemberRepository {}

void main() {
  late RocketRepository rocketRepository;
  late CrewMemberRepository crewMemberRepository;

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

  final crewMembers = List.generate(
    3,
    (i) => CrewMember(
      id: '$i',
      name: 'Alejandro Ferrero',
      status: 'active',
      agency: 'Very Good Aliens',
      image:
          'https://media-exp1.licdn.com/dms/image/C4D03AQHVNIVOMkwQaA/profile-displayphoto-shrink_200_200/0/1631637257882?e=1637193600&v=beta&t=jFm-Ckb0KS0Z5hJDbo3ZBSEZSYLHfllUf4N-IV2NDTc',
      wikipedia: 'https://www.wikipedia.org/',
      launches: ['Launch $i'],
    ),
  );

  setUp(() {
    rocketRepository = MockRocketRepository();
    crewMemberRepository = MockCrewMemberRepository();

    when(() => rocketRepository.fetchAllRockets())
        .thenAnswer((_) async => rockets);
    when(() => crewMemberRepository.fetchAllCrewMembers())
        .thenAnswer((_) async => crewMembers);
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
