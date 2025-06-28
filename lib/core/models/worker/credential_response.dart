import 'package:json_annotation/json_annotation.dart';
part 'credential_response.g.dart';

@JsonSerializable()
class CredentialResponse {
  final String fileUrl;
  // أضف أي حقول أخرى حسب الـ API

  CredentialResponse({required this.fileUrl});

  factory CredentialResponse.fromJson(Map<String, dynamic> json) => _$CredentialResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CredentialResponseToJson(this);
} 