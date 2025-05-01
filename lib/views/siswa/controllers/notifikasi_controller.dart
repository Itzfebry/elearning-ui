import 'package:get/get.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';

class NotifikasiController extends GetxController {
  var isLoading = false.obs;
  var dataNotif = [].obs;

  @override
  void onInit() {
    super.onInit();
    getNotif();
  }

  Future<void> getNotif() async {
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
        Uri.parse(ApiConstants.notifikasiEnpoit),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        dataNotif.value = data['notifications'];
      } else {
        log("Terjadi kesalahan get notifikasi: ${response.statusCode}");
      }
    } catch (e) {
      log("Error Notif: $e");
    } finally {
      isLoading(false);
    }
  }
}
