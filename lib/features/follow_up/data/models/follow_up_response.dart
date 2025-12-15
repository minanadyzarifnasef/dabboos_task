import 'package:json_annotation/json_annotation.dart';
import 'follow_up.dart';

part 'follow_up_response.g.dart';

@JsonSerializable()
class FollowUpResponse {
  bool? status;
  String? message;
  @JsonKey(name: "data")
  List<FollowUp>? followUps;

  FollowUpResponse({this.status, this.message, this.followUps});

  factory FollowUpResponse.fromJson(Map<String, dynamic> json) => _$FollowUpResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FollowUpResponseToJson(this);
}
