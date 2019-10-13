// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponse _$SearchResponseFromJson(Map<String, dynamic> json) {
  return SearchResponse()
    ..count = json['count'] as int
    ..error = json['error'] as bool
    ..results = json['results'] as List;
}

Map<String, dynamic> _$SearchResponseToJson(SearchResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'error': instance.error,
      'results': instance.results,
    };
