import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ui/models/materis.dart';

class MateriService {
  final String baseUrl = 'http://10.0.2.2:5000/materis'; // Sesuaikan dengan backend

  /// 🔹 **GET** - Ambil semua materi
  Future<List<Materi>> getAllMateri() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return Materi.fromJsonList(response.body);
    } else {
      throw Exception('Gagal mengambil data materi');
    }
  }

  /// 🔹 **GET** - Ambil materi berdasarkan Mata Pelajaran
  Future<List<Materi>> getMateriByMataPelajaran(String mataPelajaranId) async {
    final response = await http.get(Uri.parse('$baseUrl?matapelajaran_id=$mataPelajaranId'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((e) => Materi.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mengambil data materi untuk mata pelajaran ini');
    }
  }

  /// 🔹 **POST** - Tambah materi baru
  Future<void> addMateri(Materi materi) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(materi.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Gagal menambahkan materi');
    }
  }

  /// 🔹 **PUT** - Update materi berdasarkan ID
  Future<void> updateMateri(String id, Materi materi) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(materi.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal memperbarui materi');
    }
  }

  /// 🔹 **DELETE** - Hapus materi berdasarkan ID
  Future<void> deleteMateri(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus materi');
    }
  }
}
