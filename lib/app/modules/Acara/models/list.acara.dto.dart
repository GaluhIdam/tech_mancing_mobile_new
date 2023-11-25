// To parse this JSON data, do
//
//     final listAcaraDto = listAcaraDtoFromJson(jsonString);

import 'dart:convert';

ListAcaraDto listAcaraDtoFromJson(String str) =>
    ListAcaraDto.fromJson(json.decode(str));

String listAcaraDtoToJson(ListAcaraDto data) => json.encode(data.toJson());

class ListAcaraDto {
  String message;
  int status;
  Data data;

  ListAcaraDto({
    required this.message,
    required this.status,
    required this.data,
  });

  factory ListAcaraDto.fromJson(Map<String, dynamic> json) => ListAcaraDto(
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
  List<DatumListAcara> data;
  int total;

  Data({
    required this.currentPage,
    required this.data,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<DatumListAcara>.from(
            json["data"].map((x) => DatumListAcara.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "total": total,
      };
}

class DatumListAcara {
  int id;
  int idPemancingan;
  int idUser;
  String gambar;
  String namaAcara;
  String deskripsi;
  String grandPrize;
  DateTime mulai;
  DateTime akhir;
  int? status;
  DateTime createdAt;
  DateTime updatedAt;
  PemancinganAcara pemancinganAcara;

  DatumListAcara({
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
    required this.createdAt,
    required this.updatedAt,
    required this.pemancinganAcara,
  });

  factory DatumListAcara.fromJson(Map<String, dynamic> json) => DatumListAcara(
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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pemancinganAcara: PemancinganAcara.fromJson(json["pemancingan_acara"]),
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pemancingan_acara": pemancinganAcara.toJson(),
      };
}

class PemancinganAcara {
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

  PemancinganAcara({
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
  });

  factory PemancinganAcara.fromJson(Map<String, dynamic> json) =>
      PemancinganAcara(
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
