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
        .map((dynamic e) => e as String)
        .toList(),
    active: json['active'] as bool?,
    stages: json['stages'] as int?,
    boosters: json['boosters'] as int?,
    costPerLaunch: json['cost_per_launch'] as int?,
    successRatePct: json['success_rate_pct'] as int?,
    firstFlight: json['first_flight'] == null
        ? null
        : DateTime.parse(json['first_flight'] as String),
    country: json['country'] as String?,
    company: json['company'] as String?,
    wikipedia: json['wikipedia'] as String?,
  );
}

Map<String, dynamic> _$RocketToJson(Rocket instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'height': instance.height,
      'diameter': instance.diameter,
      'mass': instance.mass,
      'flickr_images': instance.flickrImages,
      'active': instance.active,
      'stages': instance.stages,
      'boosters': instance.boosters,
      'cost_per_launch': instance.costPerLaunch,
      'success_rate_pct': instance.successRatePct,
      'first_flight': instance.firstFlight?.toIso8601String(),
      'country': instance.country,
      'company': instance.company,
      'wikipedia': instance.wikipedia,
    };

Length _$LengthFromJson(Map<String, dynamic> json) {
  return Length(
    meters: (json['meters'] as num).toDouble(),
    feet: (json['feet'] as num).toDouble(),
  );
}

Map<String, dynamic> _$LengthToJson(Length instance) => <String, dynamic>{
      'meters': instance.meters,
      'feet': instance.feet,
    };

Mass _$MassFromJson(Map<String, dynamic> json) {
  return Mass(
    kg: (json['kg'] as num).toDouble(),
    lb: (json['lb'] as num).toDouble(),
  );
}

Map<String, dynamic> _$MassToJson(Mass instance) => <String, dynamic>{
      'kg': instance.kg,
      'lb': instance.lb,
    };
