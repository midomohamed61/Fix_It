// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
      userId: json['userId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'imageUrl': instance.imageUrl,
    };
