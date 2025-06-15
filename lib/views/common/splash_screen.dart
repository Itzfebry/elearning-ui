import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/auth/controllers/check_token_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final checkTokenC = Get.put(CheckTokenController());
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final role = prefs.getString('role');

    int statusToken = await checkTokenC.checkToken();

    if (statusToken == 401) {
      log("Menjalankan Logout");
      await prefs.remove('nama');
      await prefs.remove('token');
      await prefs.remove('role');
      await prefs.remove('nisn');
      await prefs.remove('nip');
      await prefs.clear();

      if (role == "siswa") {
        Get.offAllNamed(AppRoutes.login, arguments: "siswa");
      } else if (role == "guru") {
        Get.offAllNamed(AppRoutes.login, arguments: "guru");
      }
    }

    if (token != null && token.isNotEmpty) {
      // Jika token ada, arahkan ke dashboard sesuai role
      switch (role) {
        case 'siswa':
          Get.offAllNamed(AppRoutes.siswaDashboard);
          break;
        case 'guru':
          Get.offAllNamed(AppRoutes.guruDashboard);
          break;
        default:
          Get.offAllNamed(AppRoutes.login); // Jika role tidak dikenali
          break;
      }
    } else {
      if (!mounted) return;
      Get.offAllNamed(AppRoutes.welcome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100], // Bisa diganti dengan warna tema
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/skoda.png",
              width: 100,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error_outline,
                    size: 100, color: Colors.red);
              },
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
                color: Colors.white), // Animasi loading
          ],
        ),
      ),
    );
  }
}
