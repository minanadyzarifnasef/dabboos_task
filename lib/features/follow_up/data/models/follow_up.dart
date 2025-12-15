import 'package:json_annotation/json_annotation.dart';

part 'follow_up.g.dart';

enum FollowUpType { call, meeting, visit }
enum FollowUpStatus { completed, scheduled, noStatus }

@JsonSerializable()
class FollowUp {
  final String id;
  final String title;
  final String description;
  final FollowUpType type;
  
  @JsonKey(defaultValue: FollowUpStatus.noStatus)
  final FollowUpStatus status;
  
  @JsonKey(name: 'customer_name')
  final String? customerName;
  
  @JsonKey(name: 'scheduled_date')
  final DateTime? scheduledDate;

  FollowUp({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    this.status = FollowUpStatus.noStatus,
    this.customerName,
    this.scheduledDate,
  });

  factory FollowUp.fromJson(Map<String, dynamic> json) => _$FollowUpFromJson(json);
  Map<String, dynamic> toJson() => _$FollowUpToJson(this);
}
