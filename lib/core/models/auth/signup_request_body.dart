import 'package:json_annotation/json_annotation.dart';
part 'signup_request_body.g.dart';

@JsonSerializable()
class SignupRequestBody {
  final String email;
  final String name;
  final String password;
  final String role; // USER or WORKER

  SignupRequestBody({
    required this.email,
    required this.name,
    required this.password,
    required this.role,
  });

  factory SignupRequestBody.fromJson(Map<String, dynamic> json) => _$SignupRequestBodyFromJson(json);
  Map<String, dynamic> toJson() => _$SignupRequestBodyToJson(this);
} 