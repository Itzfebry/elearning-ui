// lib/services/user_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ui/constans/api_constans.dart';
import 'package:ui/models/users.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {
  static Future<List<User>> getAllUsers() async {
    final token = await const FlutterSecureStorage().read(key: 'token');
    final response = await http.get(
      Uri.parse(ApiConstants.userEnpoint),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception("Gagal mengambil data users: ${response.body}");
    }
  }

  static Future<User> getUserById(String id) async {
    final token = await const FlutterSecureStorage().read(key: 'token');
    final response = await http.get(
      Uri.parse('${ApiConstants.userEnpoint}/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("User tidak ditemukan: ${response.body}");
    }
  }

  static Future<void> createUser(User user) async {
    final token = await const FlutterSecureStorage().read(key: 'token');
    final response = await http.post(
      Uri.parse(ApiConstants.userEnpoint),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception("Gagal menambahkan user: ${response.body}");
    }
  }

  static Future<void> updateUser(String id, User user) async {
    final token = await const FlutterSecureStorage().read(key: 'token');
    final response = await http.put(
      Uri.parse('${ApiConstants.userEnpoint}/$id'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("Gagal memperbarui user: ${response.body}");
    }
  }

  static Future<void> deleteUser(String id) async {
    final token = await const FlutterSecureStorage().read(key: 'token');
    final response = await http.delete(
      Uri.parse('${ApiConstants.userEnpoint}/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode != 200) {
      throw Exception("Gagal menghapus user: ${response.body}");
    }
  }
}
