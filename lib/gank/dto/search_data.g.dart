// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchData _$SearchDataFromJson(Map<String, dynamic> json) {
  return SearchData(
      json['ganhuo_id'] as String,
      json['desc'] as String,
      json['publishedAt'] as String,
      json['readability'] as String,
      json['type'] as String,
      json['url'] as String,
      json['who'] as String);
}

Map<String, dynamic> _$SearchDataToJson(SearchData instance) =>
    <String, dynamic>{
      'ganhuo_id': instance.ganhuo_id,
      'desc': instance.desc,
      'publishedAt': instance.publishedAt,
      'readability': instance.readability,
      'type': instance.type,
      'url': instance.url,
      'who': instance.who
    };
