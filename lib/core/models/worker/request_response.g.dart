// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestResponse _$RequestResponseFromJson(Map<String, dynamic> json) =>
    RequestResponse(
      requestId: json['requestId'] as String,
      userId: json['userId'] as String,
      workerId: json['workerId'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$RequestResponseToJson(RequestResponse instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'userId': instance.userId,
      'workerId': instance.workerId,
      'status': instance.status,
    };
