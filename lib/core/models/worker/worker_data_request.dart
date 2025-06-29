import 'package:json_annotation/json_annotation.dart';
part 'worker_data_request.g.dart';

@JsonSerializable()
class WorkerDataRequest {
  final String workerId;
  final String email;
  final String name;
  final String jobTitle;
  final String address;
  final String latitude;
  final String longitude;
  final String age;
  final String about;
  final String phoneNumber;
  final String skills;

  WorkerDataRequest({
    required this.workerId,
    required this.email,
    required this.name,
    required this.jobTitle,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.age,
    required this.about,
    required this.phoneNumber,
    required this.skills,
  });

  factory WorkerDataRequest.fromJson(Map<String, dynamic> json) => _$WorkerDataRequestFromJson(json);
  Map<String, dynamic> toJson() => _$WorkerDataRequestToJson(this);
} 