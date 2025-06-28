import 'package:json_annotation/json_annotation.dart';
part 'rate_request.g.dart';

@JsonSerializable()
class RateRequest {
  final double rate;
  final String comment;

  RateRequest({required this.rate, required this.comment});

  factory RateRequest.fromJson(Map<String, dynamic> json) => _$RateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RateRequestToJson(this);
} 