// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_data_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerDataRequest _$CustomerDataRequestFromJson(Map<String, dynamic> json) =>
    CustomerDataRequest(
      userId: json['userId'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      age: json['age'] as String,
    );

Map<String, dynamic> _$CustomerDataRequestToJson(
        CustomerDataRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'age': instance.age,
    };
