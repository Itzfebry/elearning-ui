import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:ui/models/tugas_model.dart';
import 'package:http/http.dart' as http;

class TugasController extends GetxController {
  TugasModel? tugasM;
  var isLoading = false.obs;

  Future<void> getTugas({required id, required type}) async {
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
            "${ApiConstants.tugasEnpoint}?id_matpel=$id&type_tugas=$type"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        tugasM = TugasModel.fromJson(json);
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
