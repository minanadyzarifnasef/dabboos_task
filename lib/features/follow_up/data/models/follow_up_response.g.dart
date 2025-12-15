// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_up_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowUpResponse _$FollowUpResponseFromJson(Map<String, dynamic> json) =>
    FollowUpResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      followUps: (json['data'] as List<dynamic>?)
          ?.map((e) => FollowUp.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FollowUpResponseToJson(FollowUpResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.followUps,
    };
