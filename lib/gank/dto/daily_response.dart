import 'package:json_annotation/json_annotation.dart';

part 'daily_response.g.dart';

@JsonSerializable()
class DailyResponse {
  List<dynamic> category;
  bool error;
  Map<String, dynamic> results;

  DailyResponse();

  factory DailyResponse.fromJson(Map<String, dynamic> json) =>
      _$DailyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DailyResponseToJson(this);
}
