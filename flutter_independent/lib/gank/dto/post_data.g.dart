// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostData _$PostDataFromJson(Map<String, dynamic> json) {
  return PostData()
    ..id = json['_id'] as String
    ..createdAt = json['createdAt'] as String
    ..desc = json['desc'] as String
    ..images = json['images'] as List
    ..publishedAt = json['publishedAt'] as String
    ..source = json['source'] as String
    ..type = json['type'] as String
    ..url = json['url'] as String
    ..used = json['used'] as bool
    ..who = json['who'] as String;
}

Map<String, dynamic> _$PostDataToJson(PostData instance) => <String, dynamic>{
      '_id': instance.id,
      'createdAt': instance.createdAt,
      'desc': instance.desc,
      'images': instance.images,
      'publishedAt': instance.publishedAt,
      'source': instance.source,
      'type': instance.type,
      'url': instance.url,
      'used': instance.used,
      'who': instance.who,
    };
