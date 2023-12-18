import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tech_mancing/app/modules/Register/models/RegisterDTO.dart';

class ResgiterService extends GetxService {
  final String urlRegister = 'http://192.168.163.118:8000/api/register';

  Future<RegisterDto> registerUser(
      String name, email, password, re_password, no_telp) async {
    final Uri uri = Uri.parse('$urlRegister');
    final Map<String, String> queryParams = {
      'name': name,
      'email': email,
      'password': password,
      're_password': re_password,
      'no_telp': no_telp,
    };
    uri.replace(queryParameters: queryParams);
    final response = await http.post(
      Uri.parse('$urlRegister'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        're_password': re_password,
        'no_telp': no_telp,
      }),
    );
    return RegisterDto.fromJson(json.decode(response.body));
  }
}
