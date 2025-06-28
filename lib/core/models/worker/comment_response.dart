import 'package:json_annotation/json_annotation.dart';
part 'comment_response.g.dart';

@JsonSerializable()
class CommentResponse {
  final String comment;
  final String userName;
  // أضف أي حقول أخرى حسب الـ API

  CommentResponse({required this.comment, required this.userName});

  factory CommentResponse.fromJson(Map<String, dynamic> json) => _$CommentResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CommentResponseToJson(this);
} 