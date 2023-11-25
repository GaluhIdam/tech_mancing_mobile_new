// To parse this JSON data, do
//
//     final kecamatanDto = kecamatanDtoFromJson(jsonString);

import 'dart:convert';

List<KecamatanDto> kecamatanDtoFromJson(String str) => List<KecamatanDto>.from(
    json.decode(str).map((x) => KecamatanDto.fromJson(x)));

String kecamatanDtoToJson(List<KecamatanDto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KecamatanDto {
  String id;
  String regencyId;
  String name;

  KecamatanDto({
    required this.id,
    required this.regencyId,
    required this.name,
  });

  factory KecamatanDto.fromJson(Map<String, dynamic> json) => KecamatanDto(
        id: json["id"],
        regencyId: json["regency_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "regency_id": regencyId,
        "name": name,
      };
}
