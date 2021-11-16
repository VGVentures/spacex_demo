import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'launches_state.dart';

class LaunchesCubit extends Cubit<LaunchesState> {
  LaunchesCubit() : super(LaunchesInitial());
}
