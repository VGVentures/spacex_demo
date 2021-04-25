import 'dart:convert';

import 'package:spacex_api/spacex_api.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

/// Thrown if an exception occurs while making an `http` request.
class HttpException implements Exception {}

/// {@template http_request_failure}
/// Thrown if an `http` request returns a non-200 status code.
/// {@endtemplate}
class HttpRequestFailure implements Exception {
  /// {@macro http_request_failure}
  const HttpRequestFailure(this.statusCode);

  /// The status code of the response.
  final int statusCode;
}

/// Thrown when an error occurs while decoding the response body.
class JsonDecodeException implements Exception {}

/// Thrown when an error occurs while deserializing the response body.
class JsonDeserializationException implements Exception {}

/// {@template spacex_api_client}
/// A Dart API Client for the spacex REST API.
/// Learn more at https://www.spacex.com/api/
/// {@endtemplate}
class SpaceXApiClient {
  /// {@macro spacex_api_client}
  SpaceXApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  /// The host URL used for all API requests.
  ///
  /// Only exposed for testing purposes. Do not use directly.
  @visibleForTesting
  static const authority = 'api.spacexdata.com';

  final http.Client _httpClient;

  /// Fetches all SpaceX rockets.
  ///
  /// REST call: `GET /rockets`
  Future<List<Rocket>> fetchAllRockets() async {
    final uri = Uri.https(authority, '/v4/rockets');

    http.Response response;

    try {
      response = await _httpClient.get(uri);
    } catch (_) {
      throw HttpException();
    }

    if (response.statusCode != 200) {
      throw HttpRequestFailure(response.statusCode);
    }

    List body;

    try {
      body = json.decode(response.body) as List;
    } catch (_) {
      throw JsonDecodeException();
    }

    try {
      return body
          .map((item) => Rocket.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      throw JsonDeserializationException();
    }
  }
}
