import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tech_mancing/app/modules/Login/services/auth.service.dart';
import 'package:tech_mancing/app/modules/Pemancingan/models/detail-pemancingan.dto.dart';
import 'package:tech_mancing/app/modules/Pemancingan/models/kecamatan.dto.dart';
import 'package:tech_mancing/app/modules/Pemancingan/models/kota.dto.dart';
import 'package:tech_mancing/app/modules/Pemancingan/models/list-pemancingan.dart';
import 'package:tech_mancing/app/modules/Pemancingan/models/pemancingan.dto.dart';
import 'package:tech_mancing/app/modules/Pemancingan/models/provinsi.dto.dart';
import 'package:http/http.dart' as http;

class PemancinganService extends GetxService {
  final AuthService authService = Get.put(AuthService());
  final String urlProvinsi =
      'https://www.emsifa.com/api-wilayah-indonesia/api/provinces.json';
  final String urlKota =
      'https://www.emsifa.com/api-wilayah-indonesia/api/regencies/';
  final String urlKecamatan =
      'https://www.emsifa.com/api-wilayah-indonesia/api/districts/';

  final String urlPemancingan = 'http://192.168.102.118:8000/api/pemancingan';
  final String urlPemancinganByUser =
      'http://192.168.102.118:8000/api/pemancingan-by-user';
  final String urlPemancinganForUser =
      'http://192.168.102.118:8000/api/pemancingan-for-user';
  final String urlUser = 'http://192.168.102.118:8000/api/get-user';
  final String urlKomentarRate =
      'http://192.168.102.118:8000/api/komentar-rate';
  final String urlPemancinganStatus =
      'http://192.168.102.118:8000/api/pemancingan-status';

  //Get Provinsi
  Future<List<ProvinsiDto>> getProvinsi() async {
    final response = await http.get(Uri.parse(urlProvinsi));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<ProvinsiDto> provinsiList =
          data.map((item) => ProvinsiDto.fromJson(item)).toList();
      return provinsiList;
    } else {
      throw Exception('Failed to load provinsi data');
    }
  }

  //Get Kota
  Future<List<KotaDto>> getKota(String id) async {
    final response = await http.get(Uri.parse('$urlKota$id.json'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<KotaDto> kotaList =
          data.map((item) => KotaDto.fromJson(item)).toList();
      return kotaList;
    } else {
      throw Exception('Failed to load kota data');
    }
  }

  //Get Kecamatan
  Future<List<KecamatanDto>> getKecamatan(String id) async {
    try {
      final response = await http.get(Uri.parse('$urlKecamatan$id.json'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<KecamatanDto> kecamatanList =
            data.map((item) => KecamatanDto.fromJson(item)).toList();
        return kecamatanList;
      } else {
        throw Exception('Failed to load kota data');
      }
    } catch (e) {
      throw Exception('Failed to fetch kota data: $e');
    }
  }

  //Create Pemancingan
  Future<bool> createPemancingan(CreatePemancinganDto data) async {
    final tokenData = await authService.readToken();
    final bearerToken = tokenData['token'].toString();

    final request = http.MultipartRequest('POST', Uri.parse(urlPemancingan));
    request.headers['Authorization'] = 'Bearer $bearerToken';

    request.fields.addAll({
      'id_user': data.idUser.toString(),
      'category': data.category,
      'nama_pemancingan': data.namaPemancingan,
      'deskripsi': data.deskripsi,
      'provinsi': data.provinsi,
      'kota': data.kota,
      'kecamatan': data.kecamatan,
      'alamat': data.alamat,
      'buka': data.buka,
      'tutup': data.tutup,
      'latitude': data.latitude,
      'longitude': data.longitude,
      'id_provinsi': data.id_provinsi.toString(),
      'id_kota': data.id_kota.toString(),
      'id_kecamatan': data.id_kecamatan.toString(),
    });

    final imageBytes = data.image.readAsBytesSync();
    final file = http.MultipartFile.fromBytes('image', imageBytes,
        filename: 'image.jpg');
    request.files.add(file);

    final response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<ListPemancinganDto> getPemancingan(String search, String status,
      String page, String idUser, String isAdmin, String paginate) async {
    final tokenData = await authService.readToken();

    final uri = Uri.parse('$urlPemancingan');
    final queryParams = {
      'search': search,
      'status': status,
      'page': page,
      'isAdmin': isAdmin,
      'id_user': idUser,
      'paginate': paginate,
    };
    final response = await http.get(
      uri.replace(queryParameters: queryParams),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${tokenData['token']}',
      },
    );

    if (response.statusCode == 200) {
      final res = ListPemancinganDto.fromJson(json.decode(response.body));
      return res;
    } else {
      throw Exception(
          'Failed to fetch pemancingan data: ${response.statusCode}');
    }
  }

  //Get Pemancingan By User
  Future<ListPemancinganDto> getPemancinganByUser(
      String search, String page, String idUser, String paginate) async {
    final tokenData = await authService.readToken();

    final uri = Uri.parse('$urlPemancinganByUser/$idUser');
    final queryParams = {
      'search': search,
      'page': page,
      'paginate': paginate,
    };
    final response = await http.get(
      uri.replace(queryParameters: queryParams),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${tokenData['token']}',
      },
    );

    if (response.statusCode == 200) {
      final res = ListPemancinganDto.fromJson(json.decode(response.body));
      return res;
    } else {
      throw Exception(
          'Failed to fetch pemancingan data: ${response.statusCode}');
    }
  }

  //Get Pemancingan For User
  Future<ListPemancinganDto> getPemancinganForUser(
      String search, page, paginate, latitude, longitude) async {
    final tokenData = await authService.readToken();

    final uri = Uri.parse(urlPemancinganForUser);
    final queryParams = {
      'search': search,
      'page': page,
      'paginate': paginate,
      'latitude': latitude,
      'longitude': longitude,
    };
    final response = await http.get(
      uri.replace(queryParameters: queryParams),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${tokenData['token']}',
      },
    );

    if (response.statusCode == 200) {
      final res = ListPemancinganDto.fromJson(json.decode(response.body));
      return res;
    } else {
      throw Exception(
          'Failed to fetch pemancingan data: ${response.statusCode}');
    }
  }

  //Get Pemancingan For Admin
  Future<ListPemancinganDto> getPemancinganForAdmin(
      String search, page, paginate) async {
    final tokenData = await authService.readToken();

    final uri = Uri.parse(urlPemancingan);
    final queryParams = {
      'search': search,
      'page': page,
      'paginate': paginate,
    };
    final response = await http.get(
      uri.replace(queryParameters: queryParams),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${tokenData['token']}',
      },
    );

    if (response.statusCode == 200) {
      final res = ListPemancinganDto.fromJson(json.decode(response.body));
      return res;
    } else {
      throw Exception(
          'Failed to fetch pemancingan data: ${response.statusCode}');
    }
  }

  //Get Data By Id
  Future<DetailPemancinganDto> getDetailPemancingan(int id) async {
    final tokenData = await authService.readToken();

    final uri = Uri.parse('$urlPemancingan/$id');
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${tokenData['token']}',
      },
    );
    if (response.statusCode == 200) {
      final res = DetailPemancinganDto.fromJson(json.decode(response.body));
      return res;
    } else {
      throw Exception(
          'Failed to fetch pemancingan data: ${response.statusCode}');
    }
  }

  //Update status By Id
  Future<DetailPemancinganDto> updateStatusPemancingan(
      int id, String status, String pesan) async {
    final tokenData = await authService.readToken();

    final uri =
        Uri.parse('$urlPemancinganStatus/$id?status=$status&pesan=$pesan');
    final response = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${tokenData['token']}',
      },
    );
    if (response.statusCode == 200) {
      final res = DetailPemancinganDto.fromJson(json.decode(response.body));
      return res;
    } else {
      throw Exception(
          'Failed to fetch pemancingan data: ${response.statusCode}');
    }
  }

  //Update Pemancingan
  Future<bool> updatePemancingan(CreatePemancinganDto data, String id) async {
    final tokenData = await authService.readToken();
    final bearerToken = tokenData['token'].toString();
    final request =
        http.MultipartRequest('POST', Uri.parse('$urlPemancingan/$id'));

    request.headers['Authorization'] = 'Bearer $bearerToken';
    request.fields.addAll({
      'category': data.category,
      'nama_pemancingan': data.namaPemancingan,
      'deskripsi': data.deskripsi,
      'provinsi': data.provinsi,
      'kota': data.kota,
      'kecamatan': data.kecamatan,
      'alamat': data.alamat,
      'buka': data.buka,
      'tutup': data.tutup,
      'latitude': data.latitude,
      'longitude': data.longitude,
      'id_provinsi': data.id_provinsi.toString(),
      'id_kota': data.id_kota.toString(),
      'id_kecamatan': data.id_kecamatan.toString(),
    });

    final imageBytes = data.image.readAsBytesSync();
    final file = http.MultipartFile.fromBytes('image', imageBytes,
        filename: 'image.jpg');
    request.files.add(file);

    final response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //Getting Image to Be File
  Future<String> downloadImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        final appDocumentDir = await getApplicationDocumentsDirectory();
        final filePath = appDocumentDir.path + '/image.jpg';
        await File(filePath).writeAsBytes(response.bodyBytes);
        return filePath; // Return the local file path
      } else {
        throw Exception('Failed to download the image: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error downloading image: $e');
    }
  }

  //Create Komentar
  Future<bool> createKomentar(
      int id_pemancingan, int id_user, String komentar, int rate) async {
    try {
      final tokenData = await authService.readToken();
      final bearerToken = tokenData['token'].toString();
      final response = await http.post(
          Uri.parse(
              '${urlKomentarRate}?id_pemancingan=${id_pemancingan}&id_user=${id_user}&komentar=${komentar}&rate=${rate}'),
          headers: {
            'Authorization': 'Bearer $bearerToken',
          });
      if (response.statusCode == 200) {
        return true;
      } else {
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      throw Exception('Error to creating komentar: $e');
    }
  }
}
