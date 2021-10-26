import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spacex_api/spacex_api.dart';

part 'crew_member_details_state.dart';

class CrewMemberDetailsCubit extends Cubit<CrewMemberDetailsState> {
  CrewMemberDetailsCubit({required CrewMember crewMember})
      : super(CrewMemberDetailsState(crewMember: crewMember));
}
