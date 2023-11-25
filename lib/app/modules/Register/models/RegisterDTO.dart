// To parse this JSON data, do
//
//     final registerDto = registerDtoFromJson(jsonString);

import 'dart:convert';

RegisterDto registerDtoFromJson(String str) =>
    RegisterDto.fromJson(json.decode(str));

String registerDtoToJson(RegisterDto data) => json.encode(data.toJson());

class RegisterDto {
  String message;
  Errors errors;

  RegisterDto({
    required this.message,
    required this.errors,
  });

  factory RegisterDto.fromJson(Map<String, dynamic> json) => RegisterDto(
        message: json["message"],
        errors: Errors.fromJson(json["errors"] as Map<String, dynamic>? ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "errors": errors.toJson(),
      };
}

class Errors {
  List<String> name;
  List<String> email;
  List<String> noTelp;
  List<String> rePassword;

  Errors({
    required this.name,
    required this.email,
    required this.noTelp,
    required this.rePassword,
  });

  factory Errors.fromJson(Map<String, dynamic>? json) => Errors(
        name: List<String>.from(json?["name"] ?? []),
        email: List<String>.from(json?["email"] ?? []),
        noTelp: List<String>.from(json?["no_telp"] ?? []),
        rePassword: List<String>.from(json?["re_password"] ?? []),
      );

  Map<String, dynamic> toJson() => {
        "name": List<dynamic>.from(name.map((x) => x)),
        "email": List<dynamic>.from(email.map((x) => x)),
        "no_telp": List<dynamic>.from(noTelp.map((x) => x)),
        "re_password": List<dynamic>.from(rePassword.map((x) => x)),
      };
}
