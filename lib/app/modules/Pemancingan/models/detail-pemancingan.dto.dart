// To parse this JSON data, do
//
//     final detailPemancinganDto = detailPemancinganDtoFromJson(jsonString);

import 'dart:convert';

DetailPemancinganDto detailPemancinganDtoFromJson(String str) =>
    DetailPemancinganDto.fromJson(json.decode(str));

String detailPemancinganDtoToJson(DetailPemancinganDto data) =>
    json.encode(data.toJson());

class DetailPemancinganDto {
  String message;
  int status;
  Data data;

  DetailPemancinganDto({
    required this.message,
    required this.status,
    required this.data,
  });

  factory DetailPemancinganDto.fromJson(Map<String, dynamic> json) =>
      DetailPemancinganDto(
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
  int idUser;
  String category;
  String image;
  String path;
  String buka;
  String tutup;
  String namaPemancingan;
  String deskripsi;
  String idProvinsi;
  String provinsi;
  String idKota;
  String kota;
  String idKecamatan;
  String kecamatan;
  String alamat;
  String latitude;
  String longitude;
  dynamic pesan;
  dynamic status;
  DateTime createdAt;
  DateTime updatedAt;
  UserPemancingan userPemancingan;
  List<dynamic> acaraPemancingan;

  Data({
    required this.id,
    required this.idUser,
    required this.category,
    required this.image,
    required this.path,
    required this.buka,
    required this.tutup,
    required this.namaPemancingan,
    required this.deskripsi,
    required this.idProvinsi,
    required this.provinsi,
    required this.idKota,
    required this.kota,
    required this.idKecamatan,
    required this.kecamatan,
    required this.alamat,
    required this.latitude,
    required this.longitude,
    required this.pesan,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.userPemancingan,
    required this.acaraPemancingan,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        idUser: json["id_user"],
        category: json["category"],
        image: json["image"],
        path: json["path"],
        buka: json["buka"],
        tutup: json["tutup"],
        namaPemancingan: json["nama_pemancingan"],
        deskripsi: json["deskripsi"],
        idProvinsi: json["id_provinsi"],
        provinsi: json["provinsi"],
        idKota: json["id_kota"],
        kota: json["kota"],
        idKecamatan: json["id_kecamatan"],
        kecamatan: json["kecamatan"],
        alamat: json["alamat"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        pesan: json["pesan"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userPemancingan: UserPemancingan.fromJson(json["user_pemancingan"]),
        acaraPemancingan:
            List<dynamic>.from(json["acara_pemancingan"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "category": category,
        "image": image,
        "path": path,
        "buka": buka,
        "tutup": tutup,
        "nama_pemancingan": namaPemancingan,
        "deskripsi": deskripsi,
        "id_provinsi": idProvinsi,
        "provinsi": provinsi,
        "id_kota": idKota,
        "kota": kota,
        "id_kecamatan": idKecamatan,
        "kecamatan": kecamatan,
        "alamat": alamat,
        "latitude": latitude,
        "longitude": longitude,
        "pesan": pesan,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_pemancingan": userPemancingan.toJson(),
        "acara_pemancingan": List<dynamic>.from(acaraPemancingan.map((x) => x)),
      };
}

class UserPemancingan {
  int id;
  String role;
  String name;
  String noTelp;
  String email;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  UserPemancingan({
    required this.id,
    required this.role,
    required this.name,
    required this.noTelp,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserPemancingan.fromJson(Map<String, dynamic> json) =>
      UserPemancingan(
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
