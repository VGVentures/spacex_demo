import 'package:bloc/bloc.dart';
import 'package:crew_member_repository/crew_member_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:spacex_api/spacex_api.dart';

part 'crew_state.dart';

class CrewCubit extends Cubit<CrewState> {
  CrewCubit({required CrewMemberRepository crewMemberRepository})
      : _crewMemberRepository = crewMemberRepository,
        super(const CrewState());

  final CrewMemberRepository _crewMemberRepository;

  Future<void> fetchAllCrewMembers() async {
    emit(CrewState(
      status: CrewStatus.loading,
      crewMembers: state.crewMembers,
    ));

    try {
      final crewMembers = await _crewMemberRepository.fetchAllCrewMembers();
      emit(CrewState(
        status: CrewStatus.success,
        crewMembers: crewMembers,
      ));
    } on Exception {
      emit(CrewState(
        status: CrewStatus.failure,
        crewMembers: state.crewMembers,
      ));
    }
  }
}
