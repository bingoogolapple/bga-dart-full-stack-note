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

  SearchData(this.ganhuo_id, this.desc, this.publishedAt, this.readability,
      this.type, this.url, this.who);

  factory SearchData.fromJson(Map<String, dynamic> json) =>
      _$SearchDataFromJson(json);

  Map<String, dynamic> toJson() => _$SearchDataToJson(this);
}
