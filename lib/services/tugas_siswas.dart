import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tugas_siswas.dart';

class TugasSiswaService {
  final String baseUrl = 'http://10.0.2.2:5000/tugas_siswas';

  Future<List<TugasSiswa>> getAllTugasSiswa() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((e) => TugasSiswa.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mengambil data tugas siswa');
    }
  }

  Future<void> addTugasSiswa(TugasSiswa tugas) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(tugas.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Gagal menambahkan tugas siswa');
    }
  }

  Future<void> updateTugasSiswa(String id, TugasSiswa tugas) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
                                                                                              body: json.encode(tugas.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal memperbarui tugas siswa');
    }
  }

  Future<void> deleteTugasSiswa(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus tugas siswa');
    }
  }
}
