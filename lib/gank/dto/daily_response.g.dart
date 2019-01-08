// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyResponse _$DailyResponseFromJson(Map<String, dynamic> json) {
  return DailyResponse(json['category'] as List, json['error'] as bool,
      json['results'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DailyResponseToJson(DailyResponse instance) =>
    <String, dynamic>{
      'category': instance.category,
      'error': instance.error,
      'results': instance.results
    };
