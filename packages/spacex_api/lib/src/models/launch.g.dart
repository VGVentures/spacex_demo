// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Launch _$LaunchFromJson(Map<String, dynamic> json) {
  return Launch(
    id: json['id'] as String,
    name: json['name'] as String,
    details: json['details'] as String?,
    crew: (json['crew'] as List<dynamic>?)
        ?.map((e) => CrewMember.fromJson(e as Map<String, dynamic>))
        .toList(),
    flightNumber: json['flight_number'] as int?,
    rocket: json['rocket'] as String?,
    success: json['success'] as bool?,
    dateUtc: json['date_utc'] == null
        ? null
        : DateTime.parse(json['date_utc'] as String),
    dateLocal: json['date_local'] == null
        ? null
        : DateTime.parse(json['date_local'] as String),
  );
}

Map<String, dynamic> _$LaunchToJson(Launch instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'details': instance.details,
      'crew': instance.crew,
      'flight_number': instance.flightNumber,
      'rocket': instance.rocket,
      'success': instance.success,
      'date_utc': instance.dateUtc?.toIso8601String(),
      'date_local': instance.dateLocal?.toIso8601String(),
    };
