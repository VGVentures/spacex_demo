import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crew_member.g.dart';

/// {@template crew_member}
/// A model containing data about a SpaceX crew member
/// {@endtemplate}
@JsonSerializable(fieldRename: FieldRename.snake)
class CrewMember extends Equatable {
  /// {@macro crew_member}
  const CrewMember({
    required this.id,
    required this.name,
    required this.status,
    required this.agency,
    required this.image,
    required this.wikipedia,
    required this.launches,
  });

  /// The crew member's id
  final String id;

  /// The crew member's name
  final String name;

  /// The crew member's status
  ///
  /// This indicates whether the crew member is 'active' or 'inactive'
  final String status;

  /// The crew member's belonging agency
  final String agency;

  /// The crew member's image
  final String image;

  /// The crew member's information on wikipedia
  final String wikipedia;

  /// List of IDs of launches this member has been a part of
  final List<String> launches;

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        agency,
        image,
        wikipedia,
        launches,
      ];

  /// Converts a JSON [Map] into a [CrewMember] instance
  static CrewMember fromJson(Map<String, dynamic> json) =>
      _$CrewMemberFromJson(json);

  /// Converts this [CrewMember] instance into a JSON [Map]
  Map<String, dynamic> toJson() => _$CrewMemberToJson(this);

  @override
  bool get stringify => true;

  @override
  String toString() => 'Crew Member($id, $name)';
}
