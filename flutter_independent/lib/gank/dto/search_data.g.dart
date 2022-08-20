// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchData _$SearchDataFromJson(Map<String, dynamic> json) {
  return SearchData()
    ..ganhuo_id = json['ganhuo_id'] as String
    ..desc = json['desc'] as String
    ..publishedAt = json['publishedAt'] as String
    ..readability = json['readability'] as String
    ..type = json['type'] as String
    ..url = json['url'] as String
    ..who = json['who'] as String;
}

Map<String, dynamic> _$SearchDataToJson(SearchData instance) =>
    <String, dynamic>{
      'ganhuo_id': instance.ganhuo_id,
      'desc': instance.desc,
      'publishedAt': instance.publishedAt,
      'readability': instance.readability,
      'type': instance.type,
      'url': instance.url,
      'who': instance.who,
    };
