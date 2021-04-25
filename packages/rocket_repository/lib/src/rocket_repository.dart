import 'package:spacex_api/spacex_api.dart';

/// Thrown when an error occurs while looking up rockets.
class RocketsException implements Exception {}

/// Thrown when an error occurs while performing a search.
class SearchException implements Exception {}

/// {@template rocket_repository}
/// A Dart class which exposes methods to implement rocket-related
/// functionality.
/// {@endtemplate}
class RocketRepository {
  /// {@macro rocket_repository}
  RocketRepository({SpaceXApiClient? spacexApiClient})
      : _spacexApiClient = spacexApiClient ?? SpaceXApiClient();

  final SpaceXApiClient _spacexApiClient;

  /// Returns a list of all SpaceX rockets.
  ///
  /// Throws a [RocketsException] if an error occurs.
  Future<List<Rocket>> fetchAllRockets() {
    try {
      return _spacexApiClient.fetchAllRockets();
    } on Exception {
      throw RocketsException();
    }
  }
}
