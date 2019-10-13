// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyResponse _$DailyResponseFromJson(Map<String, dynamic> json) {
  return DailyResponse()
    ..category = json['category'] as List
    ..error = json['error'] as bool
    ..results = json['results'] as Map<String, dynamic>;
}

Map<String, dynamic> _$DailyResponseToJson(DailyResponse instance) =>
    <String, dynamic>{
      'category': instance.category,
      'error': instance.error,
      'results': instance.results,
    };
