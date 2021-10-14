import 'package:bloc_test/bloc_test.dart';
import 'package:crew_member_repository/crew_member_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_demo/crew/cubit/crew_cubit.dart';

class MockCrewMemberRepository extends Mock implements CrewMemberRepository {}

void main() {
  group('CrewCubit', () {
    late CrewMemberRepository crewMemberRepository;

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
      crewMemberRepository = MockCrewMemberRepository();
      when(() => crewMemberRepository.fetchAllCrewMembers())
          .thenAnswer((_) async => crewMembers);
    });

    test(
      'initial state is correct',
      () => {
        expect(
          CrewCubit(crewMemberRepository: crewMemberRepository).state,
          equals(const CrewState()),
        )
      },
    );

    blocTest<CrewCubit, CrewState>(
      'emits state with updated crew members',
      build: () => CrewCubit(crewMemberRepository: crewMemberRepository),
      act: (cubit) => cubit.fetchAllCrewMembers(),
      expect: () => [
        const CrewState(status: CrewStatus.loading),
        CrewState(
          status: CrewStatus.success,
          crewMembers: crewMembers,
        ),
      ],
    );

    blocTest<CrewCubit, CrewState>(
      'emits failure state when repository throws exception',
      build: () {
        when(() => crewMemberRepository.fetchAllCrewMembers())
            .thenThrow(Exception());
        return CrewCubit(crewMemberRepository: crewMemberRepository);
      },
      act: (cubit) => cubit.fetchAllCrewMembers(),
      expect: () => [
        const CrewState(status: CrewStatus.loading),
        const CrewState(status: CrewStatus.failure),
      ],
    );
  });
}
