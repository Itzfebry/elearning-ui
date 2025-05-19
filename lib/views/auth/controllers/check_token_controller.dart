import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:ui/constans/api_constans.dart';

class CheckTokenController extends GetxController {
  Future<int> checkToken() async {
    log("controller check token running...");
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      return 401; // langsung return
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse(ApiConstants.checkToken),
        headers: headers,
      );
      log("Status Code dari API: ${response.statusCode}");
      return response.statusCode;
    } catch (e) {
      log("Error getMe: $e");
      return 500;
    }
  }
}
