import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ui/models/matapelajarans.dart';

class MataPelajaranService extends GetxService {
  final String baseUrl = "http://10.0.2.2:5000/matapelajarans"; // Ganti dengan URL API kamu

  // Ambil semua mata pelajaran
  Future<List<MataPelajaran>> getAllMataPelajaran() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return MataPelajaran.fromJsonList(response.body);
    } else {
      throw Exception("Gagal mengambil data mata pelajaran");
    }
  }

  // Ambil mata pelajaran berdasarkan ID
  Future<MataPelajaran> getMataPelajaranById(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/$id"));
    if (response.statusCode == 200) {
      return MataPelajaran.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Mata pelajaran tidak ditemukan");
    }
  }

  // Tambah mata pelajaran baru
  Future<void> createMataPelajaran(MataPelajaran mataPelajaran) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(mataPelajaran.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception("Gagal menambahkan mata pelajaran");
    }
  }

  // Update mata pelajaran
  Future<void> updateMataPelajaran(String id, MataPelajaran mataPelajaran) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(mataPelajaran.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("Gagal memperbarui mata pelajaran");
    }
  }

  // Hapus mata pelajaran
  Future<void> deleteMataPelajaran(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    if (response.statusCode != 200) {
      throw Exception("Gagal menghapus mata pelajaran");
    }
  }
}
