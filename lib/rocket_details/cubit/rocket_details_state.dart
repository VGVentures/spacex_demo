part of 'rocket_details_cubit.dart';

class RocketDetailsState extends Equatable {
  const RocketDetailsState({required this.rocket});

  final Rocket rocket;

  @override
  List<Object> get props => [rocket];
}
