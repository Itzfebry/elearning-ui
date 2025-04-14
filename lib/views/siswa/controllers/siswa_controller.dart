import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:ui/constans/api_constans.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/widgets/my_snackbar.dart';

class SiswaController extends GetxController {
  var isLoading = false.obs;
  var dataUser = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    getMe();
  }

  Future<void> getMe() async {
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
        Uri.parse(ApiConstants.getMeEnpoint),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        dataUser.value = data['data'];
      } else {
        log("Terjadi kesalahan get data: ${response.statusCode}");
      }
    } catch (e) {
      log("Error getMe: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      if (token == null) {
        throw Exception("Token not found");
      }

      http.Response response = await http.delete(
        Uri.parse(ApiConstants.logoutEnpoint),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Get.offAllNamed(AppRoutes.login);
        await prefs.remove('nama');
        await prefs.remove('token');
        await prefs.remove('role');
        await prefs.clear();
        snackbarSuccess("Berhasil Logout");
      } else {
        debugPrint(response.body.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
