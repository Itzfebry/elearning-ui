import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:http/http.dart' as http;

class DashboardGuruController extends GetxController {
  var isLoading = false.obs;
  var dataUser = Rxn<Map<String, dynamic>>();

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
      final response = await http.get(
        Uri.parse(ApiConstants.getMeEnpoint),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        log("Get Me Response: $json");
        dataUser.value = json;
      } else {
        log("Terjadi kesalahan get data user: ${response.statusCode}");
        throw Exception("Failed to get user data");
      }
    } catch (e) {
      log("Error get user data: $e");
      rethrow;
    }
  }
}
