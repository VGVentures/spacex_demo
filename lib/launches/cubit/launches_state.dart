part of 'launches_cubit.dart';

enum LaunchesStatus { initial, loading, success, failure }

class LaunchesState extends Equatable {
  const LaunchesState({
    this.status = LaunchesStatus.initial,
    this.latestLaunch,
  });

  final LaunchesStatus status;
  final Launch? latestLaunch;

  LaunchesState copyWith({
    LaunchesStatus? status,
    Launch? latestLaunch,
  }) {
    return LaunchesState(
      status: status ?? this.status,
      latestLaunch: latestLaunch ?? this.latestLaunch,
    );
  }

  @override
  List<Object?> get props => [status, latestLaunch];
}
