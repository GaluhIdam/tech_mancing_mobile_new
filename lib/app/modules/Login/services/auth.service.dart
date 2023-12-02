import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tech_mancing/app/modules/Login/models/UserDetailDTO.dart';
import 'package:tech_mancing/core/dto/servicedto.dart';

class AuthService extends GetxService {
  final String baseURL = 'http://192.168.0.2:8000/api';
  final storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true));

  //Login
  Future<ResponseDTO> login(String email, String password) async {
    final Uri uri = Uri.parse('$baseURL/login');
    final Map<String, String> queryParams = {
      'email': email,
      'password': password,
    };
    uri.replace(queryParameters: queryParams);
    final response = await http.post(
      Uri.parse('$baseURL/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );
    return ResponseDTO.fromJson(json.decode(response.body));
  }

  //Logout
  Future<void> logout() async {
    return await storage.read(key: 'token').then((value) async {
      await http.post(
        Uri.parse('$baseURL/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $value'
        },
      );
      deleteToken();
    });
  }

  //Create Token
  Future<void> createToken(String token, String email) async {
    await storage.write(key: 'token', value: token);
    await storage.write(key: 'email', value: email);
  }

  //Read Token
  Future<Map<String, Object?>> readToken() async {
    final value = await storage.read(key: 'token');

    if (value != null && value.isNotEmpty) {
      return {'logging': true, 'token': value};
    } else {
      return {
        'logging': false,
        'token': null
      }; // or handle the case where token is not found
    }
  }

  //Delete Token
  Future<void> deleteToken() async {
    await storage.delete(key: 'token').then((value) => storage.deleteAll());
  }

  Future<UserDetailDto> getUserDetail() async {
    final tokenData = await readToken();
    final email = await storage.read(key: 'email');

    final uri = Uri.parse('$baseURL/get-user');
    final queryParams = {'email': email.toString()};
    final response = await http.get(
      uri.replace(queryParameters: queryParams),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${tokenData['token']}',
      },
    );

    if (response.statusCode == 200) {
      return UserDetailDto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch user details: ${response.statusCode}');
    }
  }
}
