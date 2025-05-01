import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';

class NotifikasiCountController extends GetxController {
  var notifCount = 0.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getNotifCount();
  }

  Future<void> getNotifCount() async {
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
        Uri.parse(ApiConstants.notifikasiCountEnpoit),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        notifCount.value = data['unread_count'];
        log(data['unread_count'].toString());
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
