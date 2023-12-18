// To parse this JSON data, do
//
//     final statsPemancinganDto = statsPemancinganDtoFromJson(jsonString);

import 'dart:convert';

StatsPemancinganDto statsPemancinganDtoFromJson(String str) =>
    StatsPemancinganDto.fromJson(json.decode(str));

String statsPemancinganDtoToJson(StatsPemancinganDto data) =>
    json.encode(data.toJson());

class StatsPemancinganDto {
  String message;
  int status;
  Data data;

  StatsPemancinganDto({
    required this.message,
    required this.status,
    required this.data,
  });

  factory StatsPemancinganDto.fromJson(Map<String, dynamic> json) =>
      StatsPemancinganDto(
        message: json["message"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  int menunggu;
  int terima;
  int tolak;

  Data({
    required this.menunggu,
    required this.terima,
    required this.tolak,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        menunggu: json["menunggu"],
        terima: json["terima"],
        tolak: json["tolak"],
      );

  Map<String, dynamic> toJson() => {
        "menunggu": menunggu,
        "terima": terima,
        "tolak": tolak,
      };
}
