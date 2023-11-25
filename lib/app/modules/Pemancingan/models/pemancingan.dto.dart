// To parse this JSON data, do
//
//     final createPemancinganDto = createPemancinganDtoFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

CreatePemancinganDto createPemancinganDtoFromJson(String str) =>
    CreatePemancinganDto.fromJson(json.decode(str));

String createPemancinganDtoToJson(CreatePemancinganDto data) =>
    json.encode(data.toJson());

class CreatePemancinganDto {
  int idUser;
  String category;
  File image;
  String namaPemancingan;
  String deskripsi;
  String provinsi;
  String kota;
  String kecamatan;
  String alamat;
  String buka;
  String tutup;
  String longitude;
  String latitude;
  int id_provinsi;
  int id_kota;
  int id_kecamatan;

  CreatePemancinganDto({
    required this.idUser,
    required this.category,
    required this.image,
    required this.namaPemancingan,
    required this.deskripsi,
    required this.provinsi,
    required this.kota,
    required this.kecamatan,
    required this.alamat,
    required this.buka,
    required this.tutup,
    required this.longitude,
    required this.latitude,
    required this.id_provinsi,
    required this.id_kota,
    required this.id_kecamatan,
  });

  factory CreatePemancinganDto.fromJson(Map<String, dynamic> json) =>
      CreatePemancinganDto(
        idUser: json["id_user"],
        category: json["category"],
        image: json["image"],
        namaPemancingan: json["nama_pemancingan"],
        deskripsi: json["deskripsi"],
        provinsi: json["provinsi"],
        kota: json["kota"],
        kecamatan: json["kecamatan"],
        alamat: json["alamat"],
        buka: json["buka"],
        tutup: json["tutup"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        id_provinsi: json["id_provinsi"],
        id_kota: json["id_kota"],
        id_kecamatan: json["id_kecamatan"],
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "category": category,
        "image": image,
        "nama_pemancingan": namaPemancingan,
        "deskripsi": deskripsi,
        "provinsi": provinsi,
        "kota": kota,
        "kecamatan": kecamatan,
        "alamat": alamat,
        "buka": buka,
        "tutup": tutup,
        "longitude": longitude,
        "latitude": latitude,
        "id_provinsi": id_provinsi,
        "id_kota": id_kota,
        "id_kecamatan": id_kecamatan,
      };
}
