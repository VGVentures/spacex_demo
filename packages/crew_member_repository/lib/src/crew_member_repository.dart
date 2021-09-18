import 'package:spacex_api/spacex_api.dart';

/// Thrown when an error occurs while looking up the crew members
class CrewMembersException implements Exception {}

/// Thrown when an error occurs while performing a search
class SearchException implements Exception {}

/// {@template crew_member_repository}
/// A Dart class which exposes methods to implement
/// crew-member-related functionality.
/// {@endtemplate}
class CrewMemberRepository {
  ///  {@macro crew_member_repository}
  CrewMemberRepository({SpaceXApiClient? spaceXApiClient})
      : _spaceXApiClient = spaceXApiClient ?? SpaceXApiClient();

  final SpaceXApiClient _spaceXApiClient;

  /// Returns a list of all SpaceX crew members
  ///
  /// Throws a [CrewMembersException] if an error occurs.
  Future<List<CrewMember>> fetchAllCrewMembers() {
    try {
      return _spaceXApiClient.fetchAllCrewMembers();
    } on Exception {
      throw CrewMembersException();
    }
  }
}
