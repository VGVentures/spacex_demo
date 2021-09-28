import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex_api/spacex_api.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required RocketRepository rocketRepository,
  })  : _rocketRepository = rocketRepository,
        super(const HomeState());

  final RocketRepository _rocketRepository;

  Future<void> fetchAllRockets() async {
    emit(HomeState(
      status: HomeStatus.loading,
      rockets: state.rockets,
    ));

    try {
      final rockets = await _rocketRepository.fetchAllRockets();
      emit(HomeState(
        status: HomeStatus.success,
        rockets: rockets,
      ));
    } on Exception {
      emit(HomeState(
        status: HomeStatus.failure,
        rockets: state.rockets,
      ));
    }
  }
}
