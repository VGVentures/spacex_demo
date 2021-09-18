import 'package:crew_member_repository/crew_member_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:test/test.dart';

class MockSpaceXApiClient extends Mock implements SpaceXApiClient {}

void main() {
  group('CrewMemberRepository', () {
    late SpaceXApiClient spaceXApiClient;
    late CrewMemberRepository subject;

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
      spaceXApiClient = MockSpaceXApiClient();
      when(() => spaceXApiClient.fetchAllCrewMembers())
          .thenAnswer((_) async => crewMembers);

      subject = CrewMemberRepository(spaceXApiClient: spaceXApiClient);
    });

    test('constructor returns normally', () {
      expect(
        () => CrewMemberRepository(),
        returnsNormally,
      );
    });

    group('.fetchAllCrewMembers', () {
      test('throws CrewMembersException when api throws an exception',
          () async {
        when(() => spaceXApiClient.fetchAllCrewMembers())
            .thenThrow(Exception());

        expect(
          () => subject.fetchAllCrewMembers(),
          throwsA(isA<CrewMembersException>()),
        );

        verify(() => spaceXApiClient.fetchAllCrewMembers()).called(1);
      });

      test('makes correct request', () async {
        await subject.fetchAllCrewMembers();

        verify(() => spaceXApiClient.fetchAllCrewMembers()).called(1);
      });
    });
  });
}
