import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spacex_api/spacex_api.dart';

part 'launch.g.dart';

/// {@template launch}
/// A model containing data about a scheduled SpaceX rocket launch.
/// {@endtemplate}
@JsonSerializable()
class Launch extends Equatable {
  /// {@macro launch}
  const Launch({
    required this.id,
    required this.name,
    required this.links,
    this.details,
    this.crew,
    this.flightNumber,
    this.rocket,
    this.success,
    this.dateUtc,
    this.dateLocal,
  });

  /// The ID of the launch.
  final String id;

  /// The name of the launch.
  final String name;

  /// The details of the launch.
  ///
  /// May be null
  final String? details;

  /// A list of crew members involved in the launch.
  ///
  /// May be `null` or empty.
  final List<CrewMember>? crew;

  /// The flightNumber of the launch
  final int? flightNumber;

  /// The ID of the rocket
  final String? rocket;

  /// If launch succeeded
  final bool? success;

  /// The launch date in UTC
  final DateTime? dateUtc;

  /// The launch date
  final DateTime? dateLocal;

  /// Available source links
  final Links links;

  @override
  List<Object?> get props => [
        id,
        name,
        details,
        crew,
        flightNumber,
        rocket,
        success,
        dateUtc,
        dateLocal
      ];

  /// Converts a JSON [Map] into a [Launch] instance
  static Launch fromJson(Map<String, dynamic> json) => _$LaunchFromJson(json);

  /// Converts this [Launch] instance into a JSON [Map]
  Map<String, dynamic> toJson() => _$LaunchToJson(this);

  @override
  String toString() => 'Latest Launch($id, $name)';
}

/// {@template links}
/// A model that represents available links to images, videos and articles.
/// {@endtemplate}
@JsonSerializable()
class Links extends Equatable {
  /// {@macro links}
  const Links({
    required this.patch,
    required this.webcast,
    required this.wikipedia,
  });

  /// The Patch for the launch mission
  final Patch patch;

  /// The launch video link
  final String webcast;

  /// The latest launch information on wikipedia
  final String wikipedia;

  @override
  List<Object> get props => [patch, webcast, wikipedia];

  /// Converts a JSON [Map] into a [Links] instance.
  static Links fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  /// Converts this [Links] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$LinksToJson(this);

  @override
  String toString() => 'Links(Webcast: $webcast, Wikipedia: $wikipedia)';
}

/// {@template patch}
/// A model that represents small and large images of the mission patch.
/// {@endtemplate}
@JsonSerializable()
class Patch extends Equatable {
  /// {@macro patch}
  const Patch({
    required this.small,
    this.large,
  });

  /// A small patch image link
  final String small;

  /// A large patch image link
  final String? large;

  @override
  List<Object?> get props => [small, large];

  /// Converts a JSON [Map] into a [Patch] instance.
  static Patch fromJson(Map<String, dynamic> json) => _$PatchFromJson(json);

  /// Converts this [Patch] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$PatchToJson(this);

  @override
  String toString() => 'Patch(Small: $small)';
}
