import 'dart:convert';

List<ProvinsiDto> provinsiDtoFromJson(String str) => List<ProvinsiDto>.from(
    json.decode(str).map((x) => ProvinsiDto.fromJson(x)));

String provinsiDtoToJson(List<ProvinsiDto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProvinsiDto {
  String id;
  String name;

  ProvinsiDto({
    required this.id,
    required this.name,
  });

  factory ProvinsiDto.fromJson(Map<String, dynamic> json) => ProvinsiDto(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
