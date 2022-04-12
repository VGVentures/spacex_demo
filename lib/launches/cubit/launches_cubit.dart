import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:spacex_api/spacex_api.dart';

part 'launches_state.dart';

class LaunchesCubit extends Cubit<LaunchesState> {
  LaunchesCubit({
    required LaunchRepository launchRepository,
  })  : _launchRepository = launchRepository,
        super(const LaunchesState());

  final LaunchRepository _launchRepository;

  Future<void> fetchLatestLaunch() async {
    emit(
      LaunchesState(
        status: LaunchesStatus.loading,
        latestLaunch: state.latestLaunch,
      ),
    );

    try {
      final latestLaunch = await _launchRepository.fetchLatestLaunch();
      emit(
        LaunchesState(
          status: LaunchesStatus.success,
          latestLaunch: latestLaunch,
        ),
      );
    } on Exception {
      emit(
        LaunchesState(
          status: LaunchesStatus.failure,
          latestLaunch: state.latestLaunch,
        ),
      );
    }
  }
}
