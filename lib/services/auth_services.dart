import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = "http://10.0.2.2:5001/auth";

  Future<Map<String, dynamic>> login(String idOrEmail, String password) async {
    final Uri url = Uri.parse("$baseUrl/login");

    Map<String, dynamic> requestBody;

    if (idOrEmail.contains('@')) {
      requestBody = {"email": idOrEmail, "password": password};
    } else {
      requestBody = {"nis": idOrEmail, "password": password};
    }

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        await prefs.setString('userName', data['user']['nama']);
        await prefs.setString('userRole', data['user']['role']);
        await prefs.setString('userId', data['user']['id']);

        print("Token saved: ${data['token']}");

        return {
          'success': true,
          'userData': data['user'],
          'message': data['message']
        };
      } else {
        return {
          'success': false,
          'message': jsonDecode(response.body)['message'] ?? 'Login gagal'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Koneksi error: $e'};
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print("Checking token at startup: $token");
    return token != null && token.isNotEmpty;
  }

  Future<Map<String, dynamic>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('userName') ?? '',
      'role': prefs.getString('userRole') ?? '',
      'id': prefs.getString('userId') ?? ''
    };
  }
}
