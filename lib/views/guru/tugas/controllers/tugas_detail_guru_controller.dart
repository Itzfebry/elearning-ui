import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:ui/models/tugas_model.dart';
import 'package:http/http.dart' as http;

class TugasDetailGuruController extends GetxController {
  TugasModel? tugasM;
  var isLoading = false.obs;
  var selectedTypeTugas = Rxn<String>();
  var isEmptyData = true.obs;
  var isFetchData = false.obs;

  Future<void> getTugas({
    required id,
    required type,
    required kelas,
    required tahunAjaran,
  }) async {
    var req = {
      'id': id,
      'type': type,
      'kelas': kelas,
      'tahunAjaran': tahunAjaran,
    };
    log(req.toString());
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
            "${ApiConstants.tugasEnpoint}?id_matpel=$id&type_tugas=$type&kelas=$kelas&tahun_ajaran=$tahunAjaran"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        tugasM = TugasModel.fromJson(json);
        if (tugasM?.data.isEmpty ?? true) {
          isEmptyData(true);
        } else {
          isEmptyData(false);
        }
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
