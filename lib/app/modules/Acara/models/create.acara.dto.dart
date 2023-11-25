// To parse this JSON data, do
//
//     final createAcaraDto = createAcaraDtoFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

CreateAcaraDto createAcaraDtoFromJson(String str) =>
    CreateAcaraDto.fromJson(json.decode(str));

String createAcaraDtoToJson(CreateAcaraDto data) => json.encode(data.toJson());

class CreateAcaraDto {
  String idPemancingan;
  String idUser;
  String namaAcara;
  String deskripsi;
  DateTime mulai;
  DateTime akhir;
  String grandPrize;
  File gambar;

  CreateAcaraDto({
    required this.idPemancingan,
    required this.idUser,
    required this.namaAcara,
    required this.deskripsi,
    required this.mulai,
    required this.akhir,
    required this.grandPrize,
    required this.gambar,
  });

  factory CreateAcaraDto.fromJson(Map<String, dynamic> json) => CreateAcaraDto(
        idPemancingan: json["id_pemancingan"],
        idUser: json["id_user"],
        namaAcara: json["nama_acara"],
        deskripsi: json["deskripsi"],
        mulai: DateTime.parse(json["mulai"]),
        akhir: DateTime.parse(json["akhir"]),
        grandPrize: json["grand_prize"],
        gambar: json["gambar"],
      );

  Map<String, dynamic> toJson() => {
        "id_pemancingan": idPemancingan,
        "id_user": idUser,
        "nama_acara": namaAcara,
        "deskripsi": deskripsi,
        "mulai": mulai.toIso8601String(),
        "akhir": akhir.toIso8601String(),
        "grand_prize": grandPrize,
        "gambar": gambar,
      };
}
