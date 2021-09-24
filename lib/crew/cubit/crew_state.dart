part of 'crew_cubit.dart';

enum CrewStatus { initial, loading, success, failure }

class CrewState extends Equatable {
  const CrewState({
    this.status = CrewStatus.initial,
    this.crewMembers,
  });

  final CrewStatus status;
  final List<CrewMember>? crewMembers;

  @override
  List<Object?> get props => [status, crewMembers];
}
