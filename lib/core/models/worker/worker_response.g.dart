// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkerResponse _$WorkerResponseFromJson(Map<String, dynamic> json) =>
    WorkerResponse(
      workerId: json['workerId'] as String,
      name: json['name'] as String,
      jobTitle: json['jobTitle'] as String,
      imageUrl: json['imageUrl'] as String?,
      rate: (json['rate'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WorkerResponseToJson(WorkerResponse instance) =>
    <String, dynamic>{
      'workerId': instance.workerId,
      'name': instance.name,
      'jobTitle': instance.jobTitle,
      'imageUrl': instance.imageUrl,
      'rate': instance.rate,
    };
