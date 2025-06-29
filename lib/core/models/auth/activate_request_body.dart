import 'package:json_annotation/json_annotation.dart';
part 'activate_request_body.g.dart';

@JsonSerializable()
class ActivateRequestBody {
  final String email;
  final String code;

  ActivateRequestBody({required this.email, required this.code});

  factory ActivateRequestBody.fromJson(Map<String, dynamic> json) => _$ActivateRequestBodyFromJson(json);
  Map<String, dynamic> toJson() => _$ActivateRequestBodyToJson(this);
} 