// To parse this JSON data, do
//
//     final userDetailDto = userDetailDtoFromJson(jsonString);

import 'dart:convert';

UserDetailDto userDetailDtoFromJson(String str) =>
    UserDetailDto.fromJson(json.decode(str));

String userDetailDtoToJson(UserDetailDto data) => json.encode(data.toJson());

class UserDetailDto {
  String message;
  Data data;

  UserDetailDto({
    required this.message,
    required this.data,
  });

  factory UserDetailDto.fromJson(Map<String, dynamic> json) => UserDetailDto(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
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
