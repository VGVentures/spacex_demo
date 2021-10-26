import 'package:spacex_api/spacex_api.dart';

/// Thrown when an error occurs while looking up the crew members
class CrewMembersException implements Exception {}

/// {@template crew_member_repository}
/// A Dart package to manage the crew domain
/// {@endtemplate}
class CrewMemberRepository {
  ///  {@macro crew_member_repository}
  CrewMemberRepository({SpaceXApiClient? spaceXApiClient})
      : _spaceXApiClient = spaceXApiClient ?? SpaceXApiClient();

  final SpaceXApiClient _spaceXApiClient;

  /// Returns an list alphabetabetically sorted by name
  /// of all SpaceX crew members
  ///
  /// Throws a [CrewMembersException] if an error occurs.
  Future<List<CrewMember>> fetchAllCrewMembers() async {
    try {
      final crewMembers = await _spaceXApiClient.fetchAllCrewMembers();

      crewMembers.sort((a, b) => a.name.compareTo(b.name));

      return crewMembers;
    } on Exception {
      throw CrewMembersException();
    }
  }
}
