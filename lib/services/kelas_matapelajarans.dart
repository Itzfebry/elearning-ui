import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ui/models/kelasmatapelajarans.dart';

class KelasMataPelajaranService {
  static Future<List<KelasMataPelajaran>> getKelasMataPelajaran() async {
    try {
      final response = await http.get(Uri.parse("http://10.0.2.2:5000/kelasmatapelajarans"));

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        // Pastikan format JSON yang diterima valid
        List<dynamic> jsonResponse = json.decode(response.body);

        // Pastikan jsonResponse tidak null atau kosong
        if (jsonResponse != null && jsonResponse.isNotEmpty) {
          print("Decoded JSON: $jsonResponse");
          return jsonResponse.map((data) => KelasMataPelajaran.fromJson(data)).toList();
        } else {
          throw Exception("Data kelas mata pelajaran kosong");
        }
      } else {
        throw Exception("Gagal memuat data kelas mata pelajaran: ${response.statusCode}");
      }
    } catch (e) {
      print("Error di Service: $e");
      throw Exception("Error: $e");
    }
  }
}
