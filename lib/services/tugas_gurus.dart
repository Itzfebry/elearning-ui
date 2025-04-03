import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tugas_gurus.dart';

class TugasGuruService {
  final String baseUrl = 'http://10.0.2.2:5000/tugas_gurus';

  Future<List<TugasGuru>> getAllTugasGuru() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((e) => TugasGuru.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mengambil data tugas guru');
    }
  }

  Future<void> addTugasGuru(TugasGuru tugas) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(tugas.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Gagal menambahkan tugas guru');
    }
  }

  Future<void> updateTugasGuru(String id, TugasGuru tugas) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(tugas.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal memperbarui tugas guru');
    }
  }

  Future<void> deleteTugasGuru(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus tugas guru');
    }
  }
  Future<List<TugasGuru>> getTugasByMataPelajaran(String mataPelajaranId) async {
    final response = await http.get(Uri.parse('$baseUrl?matapelajaran_id=$mataPelajaranId'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((e) => TugasGuru.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mengambil data tugas berdasarkan mata pelajaran');
    }
  }
}
