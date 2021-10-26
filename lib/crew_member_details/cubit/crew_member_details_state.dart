part of 'crew_member_details_cubit.dart';

class CrewMemberDetailsState extends Equatable {
  const CrewMemberDetailsState({required this.crewMember});

  final CrewMember crewMember;

  @override
  List<Object?> get props => [crewMember];
}
