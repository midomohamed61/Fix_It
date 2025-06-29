// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker_data_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkerDataRequest _$WorkerDataRequestFromJson(Map<String, dynamic> json) =>
    WorkerDataRequest(
      workerId: json['workerId'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      jobTitle: json['jobTitle'] as String,
      address: json['address'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      age: json['age'] as String,
      about: json['about'] as String,
      phoneNumber: json['phoneNumber'] as String,
      skills: json['skills'] as String,
    );

Map<String, dynamic> _$WorkerDataRequestToJson(WorkerDataRequest instance) =>
    <String, dynamic>{
      'workerId': instance.workerId,
      'email': instance.email,
      'name': instance.name,
      'jobTitle': instance.jobTitle,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'age': instance.age,
      'about': instance.about,
      'phoneNumber': instance.phoneNumber,
      'skills': instance.skills,
    };
