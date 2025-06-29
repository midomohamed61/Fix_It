// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activate_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivateRequestBody _$ActivateRequestBodyFromJson(Map<String, dynamic> json) =>
    ActivateRequestBody(
      email: json['email'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$ActivateRequestBodyToJson(
        ActivateRequestBody instance) =>
    <String, dynamic>{
      'email': instance.email,
      'code': instance.code,
    };
