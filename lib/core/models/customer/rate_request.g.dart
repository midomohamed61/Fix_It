// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RateRequest _$RateRequestFromJson(Map<String, dynamic> json) => RateRequest(
      rate: (json['rate'] as num).toDouble(),
      comment: json['comment'] as String,
    );

Map<String, dynamic> _$RateRequestToJson(RateRequest instance) =>
    <String, dynamic>{
      'rate': instance.rate,
      'comment': instance.comment,
    };
