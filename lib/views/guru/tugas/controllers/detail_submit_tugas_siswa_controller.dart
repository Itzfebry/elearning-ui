import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:ui/models/detail_submit_tugas_siswa_mode.dart';
import 'package:http/http.dart' as http;

class DetailSubmitTugasSiswaController extends GetxController {
  DetailSubmitTugasSiswaModel? detailSubmitTugasSiswaM;
  var isLoading = false.obs;

  Future<void> getSubmitTugas(
      {required id,
      required type,
      required kelas,
      required tahunAjaran}) async {
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
      isLoading(true);
      final response = await http.get(
        Uri.parse(
            "${ApiConstants.getDetailSubmitTugasSiswaEnpoint}?tugas_id=$id&kelas=$kelas&tahun_ajaran=$tahunAjaran&type_tugas=$type"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        log(json.toString());
        detailSubmitTugasSiswaM = DetailSubmitTugasSiswaModel.fromJson(json);
      } else {
        log("Terjadi kesalahan get data: ${response.statusCode}");
      }
    } catch (e) {
      log("Error get matpel simple: $e");
    } finally {
      isLoading(false);
    }
  }
}
