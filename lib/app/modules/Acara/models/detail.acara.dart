// To parse this JSON data, do
//
//     final detailAcaraDto = detailAcaraDtoFromJson(jsonString);

import 'dart:convert';

import 'package:tech_mancing/app/modules/Pemancingan/models/list-pemancingan.dart';

DetailAcaraDto detailAcaraDtoFromJson(String str) =>
    DetailAcaraDto.fromJson(json.decode(str));

String detailAcaraDtoToJson(DetailAcaraDto data) => json.encode(data.toJson());

class DetailAcaraDto {
  String message;
  int status;
  Data data;

  DetailAcaraDto({
    required this.message,
    required this.status,
    required this.data,
  });

  factory DetailAcaraDto.fromJson(Map<String, dynamic> json) => DetailAcaraDto(
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
  int id;
  int idPemancingan;
  int idUser;
  String gambar;
  String namaAcara;
  String deskripsi;
  String grandPrize;
  DateTime mulai;
  DateTime akhir;
  dynamic status;
  dynamic pesan;
  DateTime createdAt;
  DateTime updatedAt;
  DatumListPemancingan pemancinganAcara;

  Data({
    required this.id,
    required this.idPemancingan,
    required this.idUser,
    required this.gambar,
    required this.namaAcara,
    required this.deskripsi,
    required this.grandPrize,
    required this.mulai,
    required this.akhir,
    required this.status,
    required this.pesan,
    required this.createdAt,
    required this.updatedAt,
    required this.pemancinganAcara,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        idPemancingan: json["id_pemancingan"],
        idUser: json["id_user"],
        gambar: json["gambar"],
        namaAcara: json["nama_acara"],
        deskripsi: json["deskripsi"],
        grandPrize: json["grand_prize"],
        mulai: DateTime.parse(json["mulai"]),
        akhir: DateTime.parse(json["akhir"]),
        status: json["status"],
        pesan: json["pesan"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pemancinganAcara:
            DatumListPemancingan.fromJson(json["pemancingan_acara"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_pemancingan": idPemancingan,
        "id_user": idUser,
        "gambar": gambar,
        "nama_acara": namaAcara,
        "deskripsi": deskripsi,
        "grand_prize": grandPrize,
        "mulai":
            "${mulai.year.toString().padLeft(4, '0')}-${mulai.month.toString().padLeft(2, '0')}-${mulai.day.toString().padLeft(2, '0')}",
        "akhir":
            "${akhir.year.toString().padLeft(4, '0')}-${akhir.month.toString().padLeft(2, '0')}-${akhir.day.toString().padLeft(2, '0')}",
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pemancingan_acara": pemancinganAcara.toJson(),
      };
}
