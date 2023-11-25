// To parse this JSON data, do
//
//     final listPemancinganDto = listPemancinganDtoFromJson(jsonString);

import 'dart:convert';

ListPemancinganDto listPemancinganDtoFromJson(String str) =>
    ListPemancinganDto.fromJson(json.decode(str));

String listPemancinganDtoToJson(ListPemancinganDto data) =>
    json.encode(data.toJson());

class ListPemancinganDto {
  String message;
  int status;
  Data data;

  ListPemancinganDto({
    required this.message,
    required this.status,
    required this.data,
  });

  factory ListPemancinganDto.fromJson(Map<String, dynamic> json) =>
      ListPemancinganDto(
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
  int currentPage;
  List<DatumListPemancingan> data;
  int total;

  Data({
    required this.currentPage,
    required this.data,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<DatumListPemancingan>.from(
            json["data"].map((x) => DatumListPemancingan.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "total": total,
      };
}

class DatumListPemancingan {
  int? id;
  int? idUser;
  String category;
  String image;
  String path;
  String buka;
  String tutup;
  String namaPemancingan;
  String deskripsi;
  String provinsi;
  String kota;
  String kecamatan;
  String alamat;
  String latitude;
  String longitude;
  dynamic pesan;
  dynamic status;
  DateTime createdAt;
  DateTime updatedAt;
  UserPemancingan? userPemancingan;
  List<dynamic>? komentarPemancingan;

  DatumListPemancingan({
    required this.id,
    required this.idUser,
    required this.category,
    required this.image,
    required this.path,
    required this.buka,
    required this.tutup,
    required this.namaPemancingan,
    required this.deskripsi,
    required this.provinsi,
    required this.kota,
    required this.kecamatan,
    required this.alamat,
    required this.latitude,
    required this.longitude,
    required this.pesan,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.userPemancingan,
    required this.komentarPemancingan,
  });

  factory DatumListPemancingan.fromJson(Map<String, dynamic> json) =>
      DatumListPemancingan(
        id: json["id"],
        idUser: json["id_user"],
        category: json["category"],
        image: json["image"],
        path: json["path"],
        buka: json["buka"],
        tutup: json["tutup"],
        namaPemancingan: json["nama_pemancingan"],
        deskripsi: json["deskripsi"],
        provinsi: json["provinsi"],
        kota: json["kota"],
        kecamatan: json["kecamatan"],
        alamat: json["alamat"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        pesan: json["pesan"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userPemancingan: UserPemancingan.fromJson(json["user_pemancingan"]),
        komentarPemancingan:
            List<dynamic>.from(json["komentar_pemancingan"].map((x) => x)),
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
        "provinsi": provinsi,
        "kota": kota,
        "kecamatan": kecamatan,
        "alamat": alamat,
        "latitude": latitude,
        "longitude": longitude,
        "pesan": pesan,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_pemancingan": userPemancingan!.toJson(),
        "komentar_pemancingan":
            List<dynamic>.from(komentarPemancingan!.map((x) => x)),
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

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
