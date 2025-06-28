import 'package:json_annotation/json_annotation.dart';
part 'customer_data_request.g.dart';

@JsonSerializable()
class CustomerDataRequest {
  final String userId;
  final String name;
  final String phoneNumber;
  final String age;

  CustomerDataRequest({
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.age,
  });

  factory CustomerDataRequest.fromJson(Map<String, dynamic> json) => _$CustomerDataRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerDataRequestToJson(this);
} 