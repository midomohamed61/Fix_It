import 'package:json_annotation/json_annotation.dart';
part 'customer_request.g.dart';

@JsonSerializable()
class CustomerRequest {
  final String userId;
  final String workerId;
  final String address;
  final String description;
  final String salary;
  final String latitude;
  final String longitude;

  CustomerRequest({
    required this.userId,
    required this.workerId,
    required this.address,
    required this.description,
    required this.salary,
    required this.latitude,
    required this.longitude,
  });

  factory CustomerRequest.fromJson(Map<String, dynamic> json) => _$CustomerRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerRequestToJson(this);
} 