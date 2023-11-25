import 'package:get/get.dart';
import 'dart:convert';

class LoginDTO {
  final RxString email = ''.obs;
  final RxString password = ''.obs;
}

// To parse this JSON data, do
//
//     final ResponseApi = ResponseApiFromJson(jsonString);

ResponseApi responseApiFromJson(String str) =>
    ResponseApi.fromJson(json.decode(str));

String responseApiToJson(ResponseApi data) => json.encode(data.toJson());

class ResponseApi {
  String message;
  Data data;
  String token;

  ResponseApi({
    required this.message,
    required this.data,
    required this.token,
  });

  factory ResponseApi.fromJson(Map<String, dynamic> json) => ResponseApi(
        message: json["message"],
        data: Data.fromJson(json["data"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
        "token": token,
      };
}

class Data {
  int id;
  String role;
  String name;
  String noTelp;
  String email;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.role,
    required this.name,
    required this.noTelp,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        role: json["role"],
        name: json["name"],
        noTelp: json["no_telp"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
        "name": name,
        "no_telp": noTelp,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

FailedResponse failedResponseFromJson(String str) =>
    FailedResponse.fromJson(json.decode(str));

String failedResponseToJson(FailedResponse data) => json.encode(data.toJson());

class FailedResponse {
  String message;

  FailedResponse({
    required this.message,
  });

  factory FailedResponse.fromJson(Map<String, dynamic> json) => FailedResponse(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
