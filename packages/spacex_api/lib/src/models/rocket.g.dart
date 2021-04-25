// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rocket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rocket _$RocketFromJson(Map<String, dynamic> json) {
  return Rocket(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    height: Length.fromJson(json['height'] as Map<String, dynamic>),
    diameter: Length.fromJson(json['diameter'] as Map<String, dynamic>),
    mass: Mass.fromJson(json['mass'] as Map<String, dynamic>),
    flickrImages: (json['flickr_images'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    active: json['active'] as bool,
    stages: json['stages'] as int,
    boosters: json['boosters'] as int,
    costPerLaunch: json['cost_per_launch'] as int,
    successRatePct: json['success_rate_pct'] as int,
    firstFlight: DateTime.parse(json['first_flight'] as String),
    country: json['country'] as String,
    company: json['company'] as String,
    wikipedia: json['wikipedia'] as String,
  );
}

Length _$LengthFromJson(Map<String, dynamic> json) {
  return Length(
    meters: (json['meters'] as num).toDouble(),
    feet: (json['feet'] as num).toDouble(),
  );
}

Mass _$MassFromJson(Map<String, dynamic> json) {
  return Mass(
    kg: json['kg'] as int,
    lb: json['lb'] as int,
  );
}
