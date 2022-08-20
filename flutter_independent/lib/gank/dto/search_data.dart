import 'package:json_annotation/json_annotation.dart';

part 'search_data.g.dart';

@JsonSerializable()
class SearchData {
  String ganhuo_id;
  String desc;
  String publishedAt;
  String readability;
  String type;
  String url;
  String who;

  SearchData();

  factory SearchData.fromJson(Map<String, dynamic> json) =>
      _$SearchDataFromJson(json);

  Map<String, dynamic> toJson() => _$SearchDataToJson(this);
}
