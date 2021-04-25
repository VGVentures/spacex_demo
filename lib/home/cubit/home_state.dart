part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.rockets,
  });

  final HomeStatus status;
  final List<Rocket>? rockets;

  @override
  List<Object?> get props => [status, rockets];
}
