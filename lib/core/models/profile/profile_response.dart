import 'package:json_annotation/json_annotation.dart';
part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  final String userId;
  final String name;
  final String email;
  final String role;
  final String? imageUrl;
  // أضف أي حقول أخرى حسب الـ API

  ProfileResponse({
    required this.userId,
    required this.name,
    required this.email,
    required this.role,
    this.imageUrl,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => _$ProfileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
} 