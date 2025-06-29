import 'package:json_annotation/json_annotation.dart';
part 'worker_response.g.dart';

@JsonSerializable()
class WorkerResponse {
  final String workerId;
  final String name;
  final String jobTitle;
  final String? imageUrl;
  final double? rate;
  // أضف أي حقول أخرى حسب الـ API

  WorkerResponse({
    required this.workerId,
    required this.name,
    required this.jobTitle,
    this.imageUrl,
    this.rate,
  });

  factory WorkerResponse.fromJson(Map<String, dynamic> json) => _$WorkerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WorkerResponseToJson(this);
} 