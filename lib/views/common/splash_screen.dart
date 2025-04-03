import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 2)); // Simulasi loading

    final prefs = Get.find<SharedPreferences>();
    final token = prefs.getString('token');
    final role = prefs.getString('role'); // Ambil role user jika ada

    if (token != null && token.isNotEmpty) {
      // Jika token ada, arahkan ke dashboard sesuai role
      switch (role) {
        case 'siswa':
          Get.offAllNamed(AppRoutes.siswaDashboard);
          break;
        case 'guru':
          Get.offAllNamed(AppRoutes.guruDashboard);
          break;
        case 'admin':
          Get.offAllNamed(AppRoutes.adminDashboard);
          break;
        default:
          Get.offAllNamed(AppRoutes.login); // Jika role tidak dikenali
          break;
      }
    } else {
      if (!mounted) return;
      // Jika tidak ada token, arahkan ke halaman Welcome
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
            Image.asset("assets/images/skoda.png", width: 100), // Tambahkan logo
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.white), // Animasi loading
          ],
        ),
      ),
    );
  }
}
