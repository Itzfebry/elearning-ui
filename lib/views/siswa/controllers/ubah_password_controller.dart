import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:ui/constans/api_constans.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/widgets/my_snackbar.dart';

class UbahPasswordController extends GetxController {
  var isLoading = false.obs;
  final oldPasswordC = TextEditingController().obs;
  final newPasswordC = TextEditingController().obs;
  final confirmPasswordC = TextEditingController().obs;

  Future<void> ubahPassword() async {
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
      Map body = {
        'old_password': oldPasswordC.value.text,
        'new_password': newPasswordC.value.text,
        'new_password_confirmation': confirmPasswordC.value.text,
      };
      log(body.toString());
      final response = await http.post(
        Uri.parse(ApiConstants.ubahPasswordEnpoint),
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status'] == false) {
          snackbarAlert("Gagal", json['message'], Colors.red.shade800);
          return;
        } else {
          Get.back();
          snackbarAlert("Berhasil", json['message'], Colors.green.shade800);
        }
      } else {
        log("Terjadi kesalahan ubah password : ${response.statusCode}");
        snackbarAlert(
            "Berhasil",
            "Terjadi kesalahan ubah password : ${response.statusCode}",
            Colors.green.shade800);
      }
    } catch (e) {
      log("Error update password simple: $e");
    } finally {
      isLoading(false);
    }
  }
}
