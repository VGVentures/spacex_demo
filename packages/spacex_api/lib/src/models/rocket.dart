import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rocket.g.dart';

/// {@template rocket}
/// A model containing data about a SpaceX rocket.
/// {@endtemplate}
@JsonSerializable(
  createToJson: false,
  fieldRename: FieldRename.snake,
)
class Rocket extends Equatable {
  /// {@macro rocket}
  Rocket({
    required this.id,
    required this.name,
    required this.description,
    required this.height,
    required this.diameter,
    required this.mass,
    required this.flickrImages,
    required this.active,
    required this.stages,
    required this.boosters,
    required this.costPerLaunch,
    required this.successRatePct,
    required this.firstFlight,
    required this.country,
    required this.company,
    required this.wikipedia,
  });

  /// The ID of the rocket.
  final String id;

  /// The name of the rocket.
  final String name;

  /// A description of this rocket.
  final String description;

  /// The height of the rocket.
  final Length height;

  /// The diameter of the rocket.
  final Length diameter;

  /// The mass of the rocket.
  final Mass mass;

  /// A collection of images if this rocket hosted on https://flickr.com
  ///
  /// May be empty.
  final List<String> flickrImages;

  /// Indicates if this rocket is currently in use.
  final bool active;

  /// The amount of stages this rocket's boosters has.
  final int stages;

  /// The amount of boosters this rocket has.
  final int boosters;

  /// The amount in dollars it costs on average to launch this rocket.
  final int costPerLaunch;

  /// The percentage of times this rocket has been launched succesfully.
  ///
  /// This value must be in between `0` and `100`.
  final int successRatePct;

  /// The date this rocket was first launched.
  final DateTime firstFlight;

  /// The country in which this rocket was built.
  final String country;

  /// The name of the company that made this rocket.
  final String company;

  /// A URL to the Wikipedia page of this rocket.
  final String wikipedia;

  @override
  List<Object> get props => [
        id,
        name,
        description,
        height,
        diameter,
        mass,
        flickrImages,
        active,
        stages,
        boosters,
        costPerLaunch,
        successRatePct,
        firstFlight,
        country,
        company,
        wikipedia,
      ];

  /// Converts a JSON [Map] into a [Rocket] instance.
  static Rocket fromJson(Map<String, dynamic> json) => _$RocketFromJson(json);

  @override
  String toString() => 'Rocket($id, $name)';
}

/// {@template length}
/// A model that represents a certain length in both meters and feet.
/// {@endtemplate}
@JsonSerializable(
  createToJson: false,
  fieldRename: FieldRename.snake,
)
class Length {
  /// {@macro length}
  Length({
    required this.meters,
    required this.feet,
  });

  /// The length in metric meters.
  final double meters;

  /// The length in imperial feet.
  final double feet;

  /// Converts a JSON [Map] into a [Length] instance.
  static Length fromJson(Map<String, dynamic> json) => _$LengthFromJson(json);

  @override
  String toString() => 'Length($meters m, $feet ft)';
}

/// {@template mass}
/// A model that represents a certain length in both meters and feet.
/// {@endtemplate}
@JsonSerializable(
  createToJson: false,
  fieldRename: FieldRename.snake,
)
class Mass {
  /// {@macro mass}
  Mass({
    required this.kg,
    required this.lb,
  });

  /// The mass in metric kilograms.
  final int kg;

  /// The mass in imperial pounds.
  final int lb;

  /// Converts a JSON [Map] into a [Mass] instance.
  static Mass fromJson(Map<String, dynamic> json) => _$MassFromJson(json);

  @override
  String toString() => 'Mass($kg kg, $lb lb)';
}
