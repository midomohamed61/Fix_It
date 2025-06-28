import 'package:json_annotation/json_annotation.dart';
part 'signup_response.g.dart';

@JsonSerializable()
class SignupResponse {
  final int id;
  final String email;
  final String name;

  SignupResponse({required this.id, required this.email, required this.name});

  factory SignupResponse.fromJson(Map<String, dynamic> json) => _$SignupResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);
} 