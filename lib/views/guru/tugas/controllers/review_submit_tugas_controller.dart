import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:ui/widgets/my_snackbar.dart';
import 'package:http/http.dart' as http;

class ReviewSubmitTugasController extends GetxController {
  var isLoading = false.obs;
  var nilai = 0.0.obs;
  var taskName = ''.obs;
  var taskId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    taskId.value = args['id_tugas']?.toString() ?? '';
    taskName.value = args['nama']?.toString() ?? 'Tidak ada nama tugas';
    log('Task ID: ${taskId.value}');
    log('Task Name: ${taskName.value}');
  }

  Future<void> updateNilai() async {
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
      final response = await http.post(
        Uri.parse("${ApiConstants.baseUrlApi}/update-nilai"),
        headers: headers,
        body: jsonEncode({
          'id': Get.arguments['id'],
          'nilai': nilai.value.toInt(),
        }),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status']) {
          snackbarSuccess(json['message']);
          Get.back();
        } else {
          snackbarfailed(json['message']);
        }
      } else {
        snackbarfailed("Terjadi kesalahan saat mengupdate nilai");
      }
    } catch (e) {
      log("Error update nilai: $e");
      snackbarfailed("Terjadi kesalahan saat mengupdate nilai");
    } finally {
      isLoading(false);
    }
  }
}
