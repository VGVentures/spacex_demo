import 'package:flutter_test/flutter_test.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_demo/crew_member_details/cubit/crew_member_details_cubit.dart';

void main() {
  group('CrewMemberDetailsCubit', () {
    const crewMember = CrewMember(
      id: '0',
      name: 'Alejandro Ferrero',
      status: 'active',
      agency: 'Very Good Aliens',
      image:
          'https://media-exp1.licdn.com/dms/image/C4D03AQHVNIVOMkwQaA/profile-displayphoto-shrink_200_200/0/1631637257882?e=1637193600&v=beta&t=jFm-Ckb0KS0Z5hJDbo3ZBSEZSYLHfllUf4N-IV2NDTc',
      wikipedia: 'https://www.wikipedia.org/',
      launches: ['Launch 1'],
    );

    test('initial state is correct', () {
      expect(
        CrewMemberDetailsCubit(crewMember: crewMember).state,
        equals(const CrewMemberDetailsState(crewMember: crewMember)),
      );
    });
  });
}
