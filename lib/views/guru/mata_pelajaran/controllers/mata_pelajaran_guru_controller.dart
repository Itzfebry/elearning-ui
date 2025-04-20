import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:ui/models/mata_pelajaran_model.dart';
import 'package:http/http.dart' as http;

class MataPelajaranGuruController extends GetxController {
  var isLoading = false.obs;
  MataPelajaranModel? mataPelajaranM;
  var isEmptyData = true.obs;
  var isFetchData = false.obs;

  Future<void> getMatPel({
    required String kelas,
    required String tahunAjaran,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception("Token not found");
    }
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      isFetchData(true);
      isLoading(true);
      final response = await http.get(
        Uri.parse(
            "${ApiConstants.mataPelajaranEnpoint}?kelas=$kelas&tahun_ajaran=$tahunAjaran"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        mataPelajaranM = MataPelajaranModel.fromJson(data);
        if (mataPelajaranM?.data.isEmpty ?? true) {
          isEmptyData(true);
        } else {
          isEmptyData(false);
        }
      } else {
        log("Terjadi kesalahan get data: ${response.statusCode}");
      }
    } catch (e) {
      log("Error getMe: $e");
    } finally {
      isLoading(false);
    }
  }
}
