import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';

class SelectionPage extends StatelessWidget {
  const SelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Langsung redirect ke login siswa saat halaman ini dibuka
    Future.microtask(() {
      Get.offAllNamed(AppRoutes.login, arguments: 'siswa');
    });
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
