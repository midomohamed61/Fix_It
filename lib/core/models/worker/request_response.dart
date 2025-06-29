import 'package:json_annotation/json_annotation.dart';
part 'request_response.g.dart';

@JsonSerializable()
class RequestResponse {
  final String requestId;
  final String userId;
  final String workerId;
  final String status;
  // أضف أي حقول أخرى حسب الـ API

  RequestResponse({
    required this.requestId,
    required this.userId,
    required this.workerId,
    required this.status,
  });

  factory RequestResponse.fromJson(Map<String, dynamic> json) => _$RequestResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RequestResponseToJson(this);
} 