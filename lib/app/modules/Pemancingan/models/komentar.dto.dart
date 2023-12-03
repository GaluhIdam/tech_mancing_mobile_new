// To parse this JSON data, do
//
//     final komentarDto = komentarDtoFromJson(jsonString);

import 'dart:convert';

KomentarDto komentarDtoFromJson(String str) =>
    KomentarDto.fromJson(json.decode(str));

String komentarDtoToJson(KomentarDto data) => json.encode(data.toJson());

class KomentarDto {
  String message;
  int status;
  Data data;

  KomentarDto({
    required this.message,
    required this.status,
    required this.data,
  });

  factory KomentarDto.fromJson(Map<String, dynamic> json) => KomentarDto(
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
  List<DatumKomentar> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  Data({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<DatumKomentar>.from(
            json["data"].map((x) => DatumKomentar.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class DatumKomentar {
  int id;
  int idPemancingan;
  int idUser;
  String komentar;
  int rate;
  DateTime createdAt;
  DateTime updatedAt;
  UserKomentar userKomentar;

  DatumKomentar({
    required this.id,
    required this.idPemancingan,
    required this.idUser,
    required this.komentar,
    required this.rate,
    required this.createdAt,
    required this.updatedAt,
    required this.userKomentar,
  });

  factory DatumKomentar.fromJson(Map<String, dynamic> json) => DatumKomentar(
        id: json["id"],
        idPemancingan: json["id_pemancingan"],
        idUser: json["id_user"],
        komentar: json["komentar"],
        rate: json["rate"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userKomentar: UserKomentar.fromJson(json["user_komentar"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_pemancingan": idPemancingan,
        "id_user": idUser,
        "komentar": komentar,
        "rate": rate,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_komentar": userKomentar.toJson(),
      };
}

class UserKomentar {
  int id;
  String role;
  String name;
  String noTelp;
  String email;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  UserKomentar({
    required this.id,
    required this.role,
    required this.name,
    required this.noTelp,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserKomentar.fromJson(Map<String, dynamic> json) => UserKomentar(
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
