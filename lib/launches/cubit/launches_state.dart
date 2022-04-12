part of 'launches_cubit.dart';

enum LaunchesStatus { initial, loading, success, failure }

class LaunchesState extends Equatable {
  const LaunchesState({
    this.status = LaunchesStatus.initial,
    this.latestLaunch,
  });

  final LaunchesStatus status;
  final Launch? latestLaunch;

  @override
  List<Object?> get props => [status, latestLaunch];
}
