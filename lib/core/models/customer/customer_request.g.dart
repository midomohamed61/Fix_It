// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerRequest _$CustomerRequestFromJson(Map<String, dynamic> json) =>
    CustomerRequest(
      userId: json['userId'] as String,
      workerId: json['workerId'] as String,
      address: json['address'] as String,
      description: json['description'] as String,
      salary: json['salary'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
    );

Map<String, dynamic> _$CustomerRequestToJson(CustomerRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'workerId': instance.workerId,
      'address': instance.address,
      'description': instance.description,
      'salary': instance.salary,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
