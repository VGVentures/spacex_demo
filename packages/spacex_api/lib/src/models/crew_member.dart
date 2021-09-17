import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crew_member.g.dart';

/// {@template crew}
/// A model containing data about a SpaceX crew member
/// {@endtemplate}
@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class CrewMember extends Equatable {
  /// {@macro crewMember}
  const CrewMember({
    required this.id,
    required this.name,
    required this.status,
    required this.agency,
    required this.image,
    required this.wikipedia,
    required this.launches,
  });

  /// CrewMember member's id
  final String id;

  /// CrewMember member's name
  final String name;

  /// CrewMember member's status
  final String status;

  /// CrewMember member's belonging agency
  final String agency;

  /// CrewMember member's image
  final String image;

  /// CrewMember member's information on wikipedia
  final String wikipedia;

  /// Different launches a crew member has been a part of
  // TODO: CREATE LAUNCH MODEL
  final List<String> launches;

  @override
  // TODO: implement props
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
  @override
  Map<String, dynamic> toJson() => _$CrewMemberToJson(this);

  @override
  String toString() => 'Crew Member($id, $name)';
}
