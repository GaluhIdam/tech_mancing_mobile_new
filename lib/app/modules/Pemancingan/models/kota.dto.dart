// To parse this JSON data, do
//
//     final kotaDto = kotaDtoFromJson(jsonString);

import 'dart:convert';

List<KotaDto> kotaDtoFromJson(String str) =>
    List<KotaDto>.from(json.decode(str).map((x) => KotaDto.fromJson(x)));

String kotaDtoToJson(List<KotaDto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KotaDto {
  String id;
  String provinceId;
  String name;

  KotaDto({
    required this.id,
    required this.provinceId,
    required this.name,
  });

  factory KotaDto.fromJson(Map<String, dynamic> json) => KotaDto(
        id: json["id"],
        provinceId: json["province_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "province_id": provinceId,
        "name": name,
      };
}
