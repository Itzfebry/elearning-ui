import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/routes/app_routes.dart';



class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final prefs = Get.find<SharedPreferences>();
    final token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      return const RouteSettings(name: AppRoutes.login);
    }
    return null; // Lanjutkan ke halaman yang diminta
  }
}