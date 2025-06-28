import 'package:json_annotation/json_annotation.dart';
part 'rate_response.g.dart';

@JsonSerializable()
class RateResponse {
  final double rate;
  // أضف أي حقول أخرى حسب الـ API

  RateResponse({required this.rate});

  factory RateResponse.fromJson(Map<String, dynamic> json) => _$RateResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RateResponseToJson(this);
} 