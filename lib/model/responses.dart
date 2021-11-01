import 'dart:convert';

class ResponseModel {
  int? data;
  String? message;
  String? error;
  ResponseModel({
    required this.data,
    required this.message,
    required this.error,
  });

  Map<String, dynamic> toMap() {
    return {'data': data, 'message': message, "error": error};
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
        data: map['data'] != null ? map['data'][0] : null,
        message: map['message'] ?? null,
        error: map['error']);
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source));
}
