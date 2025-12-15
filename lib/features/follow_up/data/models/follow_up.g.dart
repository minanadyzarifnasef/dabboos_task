// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_up.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowUp _$FollowUpFromJson(Map<String, dynamic> json) => FollowUp(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  type: $enumDecode(_$FollowUpTypeEnumMap, json['type']),
  status:
      $enumDecodeNullable(_$FollowUpStatusEnumMap, json['status']) ??
      FollowUpStatus.noStatus,
  customerName: json['customer_name'] as String?,
  scheduledDate: json['scheduled_date'] == null
      ? null
      : DateTime.parse(json['scheduled_date'] as String),
);

Map<String, dynamic> _$FollowUpToJson(FollowUp instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'type': _$FollowUpTypeEnumMap[instance.type]!,
  'status': _$FollowUpStatusEnumMap[instance.status]!,
  'customer_name': instance.customerName,
  'scheduled_date': instance.scheduledDate?.toIso8601String(),
};

const _$FollowUpTypeEnumMap = {
  FollowUpType.call: 'call',
  FollowUpType.meeting: 'meeting',
  FollowUpType.visit: 'visit',
};

const _$FollowUpStatusEnumMap = {
  FollowUpStatus.completed: 'completed',
  FollowUpStatus.scheduled: 'scheduled',
  FollowUpStatus.noStatus: 'noStatus',
};
