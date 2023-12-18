import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tech_mancing/app/modules/Acara/models/create.acara.dto.dart';
import 'package:tech_mancing/app/modules/Acara/models/detail.acara.dart';
import 'package:tech_mancing/app/modules/Acara/models/list.acara.dto.dart';
import 'package:tech_mancing/app/modules/Login/services/auth.service.dart';
import 'package:http/http.dart' as http;
import 'package:tech_mancing/app/modules/Pemancingan/models/StatsPemancingan.dto.dart';

class AcaraService extends GetxService {
  final AuthService authService = Get.put(AuthService());

  final String urlAcara = 'http://192.168.163.118:8000/api/acara';
  final String urlAcaraUser = 'http://192.168.163.118:8000/api/acara-user/';
  final String urlAcaraDetail = 'http://192.168.163.118:8000/api/acara/';
  final String urlAcaraStats = 'http://192.168.163.118:8000/api/acara-stats';
  final String urlAcaraAdmin = 'http://192.168.163.118:8000/api/acara-admin';
  final String urlAcaraApprove =
      'http://192.168.163.118:8000/api/acara-approve';

  //Get Acara For User
  Future<ListAcaraDto> getAcaraForUser(
      String search, String page, String paginate) async {
    final tokenData = await authService.readToken();
    final uri = Uri.parse(urlAcara);
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
      final res = ListAcaraDto.fromJson(json.decode(response.body));
      return res;
    } else {
      throw Exception('Failed to fetch acara data: ${response.statusCode}');
    }
  }

  //Get Acara By User
  Future<ListAcaraDto> getAcara(
      String search, String page, String paginate, String idUser) async {
    final tokenData = await authService.readToken();
    final uri = Uri.parse('$urlAcaraUser$idUser');
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
      final res = ListAcaraDto.fromJson(json.decode(response.body));
      return res;
    } else {
      throw Exception('Failed to fetch acara data: ${response.statusCode}');
    }
  }

  //Get Acara By Id
  Future<DetailAcaraDto> getAcaraById(int idAcara) async {
    final tokenData = await authService.readToken();
    final uri = Uri.parse('$urlAcaraDetail$idAcara');
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${tokenData['token']}',
      },
    );
    if (response.statusCode == 200) {
      final res = DetailAcaraDto.fromJson(json.decode(response.body));
      return res;
    } else {
      throw Exception('Failed to fetch acara data: ${response.statusCode}');
    }
  }

  //Create Acara
  Future<bool> createAcara(CreateAcaraDto data) async {
    final tokenData = await authService.readToken();
    final bearerToken = tokenData['token'].toString();
    final request = http.MultipartRequest('POST', Uri.parse(urlAcara));
    request.headers['Authorization'] = 'Bearer $bearerToken';

    request.fields.addAll({
      'id_user': data.idUser,
      'id_pemancingan': data.idPemancingan,
      'nama_acara': data.namaAcara,
      'deskripsi': data.deskripsi,
      'mulai': data.mulai.toString(),
      'akhir': data.akhir.toString(),
      'grand_prize': data.grandPrize,
    });

    final imageBytes = data.gambar.readAsBytesSync();
    final file = http.MultipartFile.fromBytes('gambar', imageBytes,
        filename: 'image.jpg');
    request.files.add(file);

    final response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateAcara(CreateAcaraDto data, String id) async {
    final tokenData = await authService.readToken();
    final bearerToken = tokenData['token'].toString();
    final request = http.MultipartRequest('POST', Uri.parse('$urlAcara/$id'));
    request.headers['Authorization'] = 'Bearer $bearerToken';
    request.fields.addAll({
      'id_pemancingan': data.idPemancingan,
      'nama_acara': data.namaAcara,
      'deskripsi': data.deskripsi,
      'mulai': data.mulai.toString(),
      'akhir': data.akhir.toString(),
      'grand_prize': data.grandPrize,
    });

    final imageBytes = data.gambar.readAsBytesSync();
    final file = http.MultipartFile.fromBytes('gambar', imageBytes,
        filename: 'image.jpg');
    request.files.add(file);
    print(request);
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

  Future<StatsPemancinganDto> getStatsAcara() async {
    try {
      final tokenData = await authService.readToken();

      final uri = Uri.parse(urlAcaraStats);
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${tokenData['token']}',
        },
      );
      if (response.statusCode == 200) {
        final res = StatsPemancinganDto.fromJson(json.decode(response.body));
        return res;
      } else {
        throw Exception('Failed to fetch acara data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error to stats acara: $e');
    }
  }

  Future<ListAcaraDto> getAcaraDataForAdmin(
      String filter, String search, String page, String paginate) async {
    final tokenData = await authService.readToken();
    final uri = Uri.parse('$urlAcaraAdmin/$filter');
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
      final res = ListAcaraDto.fromJson(json.decode(response.body));
      return res;
    } else {
      throw Exception(
          'Failed to fetch acara admin data: ${response.statusCode}');
    }
  }

  Future<bool> updateStatusAcara(int id, String status, String pesan) async {
    final tokenData = await authService.readToken();

    final uri = Uri.parse('$urlAcaraApprove/$id?status=$status&pesan=$pesan');
    final response = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${tokenData['token']}',
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(
          'Failed to fetch status acara data: ${response.statusCode}');
    }
  }
}
