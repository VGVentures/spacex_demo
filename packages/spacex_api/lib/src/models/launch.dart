import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spacex_api/spacex_api.dart';

part 'launch.g.dart';

/// {@template launch}
/// A model containing data about a launch
/// {@endtemplate}
@JsonSerializable(fieldRename: FieldRename.snake)
class Launch extends Equatable {
  /// {@macro launch}
  const Launch({
    required this.id,
    required this.name,
    required this.details,
    required this.crew,
    required this.flightNumber,
    this.rocket,
    this.success,
    this.dateUtc,
    this.dateLocal,
  });

  ///The ID of the launch.
  final String id;

  ///The name of the launch.
  final String name;

  ///The details of the launch.
  final String details;

  /// A List of crew members
  ///
  /// May be empty.
  final List<CrewMember> crew;

  final int? flightNumber;

  ///The name of the rocket
  final Rocket? rocket;

  ///If launch succeeded
  final bool? success;

  ///The launch date in UTC
  final DateTime? dateUtc;

  ///The launch date
  final DateTime? dateLocal;

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
  bool get stringify => true;

  @override
  String toString() => 'Launch($id, $name)';
}
