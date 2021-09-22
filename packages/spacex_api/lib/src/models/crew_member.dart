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

  /// List of launches IDs a member has been a part of
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
  String toString() => 'Crew Member($id, $name)';
}
