import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:ui/models/kelasmatapelajarans.dart';

class KelasMataPelajaranService {
  static Future<List<KelasMataPelajaran>> getKelasMataPelajaran() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      print("object TESSS");
      print(token);

      final header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse(ApiConstants.klsMatpelEnpoint),
        headers: header,
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        // Pastikan format JSON yang diterima valid
        List<dynamic> jsonResponse = json.decode(response.body);

        // Pastikan jsonResponse tidak null atau kosong
        if (jsonResponse.isNotEmpty) {
          print("Decoded JSON: $jsonResponse");
          return jsonResponse
              .map((data) => KelasMataPelajaran.fromJson(data))
              .toList();
        } else {
          throw Exception("Data kelas mata pelajaran kosong");
        }
      } else {
        throw Exception(
            "Gagal memuat data kelas mata pelajaran: ${response.statusCode}");
      }
    } catch (e) {
      print("Error di Service: $e");
      throw Exception("Error: $e");
    }
  }
}
