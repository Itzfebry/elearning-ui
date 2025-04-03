import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';

class SelectionPage extends StatelessWidget {
  const SelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue, width: 2),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _roleButton("Siswa", "siswa", "https://cdn-icons-png.flaticon.com/512/201/201818.png"),
                _roleButton("Guru", "guru", "https://cdn-icons-png.flaticon.com/512/1995/1995574.png"),
                _roleButton("Admin", "admin", "https://cdn-icons-png.flaticon.com/512/2206/2206368.png"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _roleButton(String label, String role, String imageUrl) {
    return GestureDetector(
      onTap: () {
        Get.offAllNamed(AppRoutes.login, arguments: role); // Pastikan tidak bisa kembali ke Selection
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        width: 300,
        decoration: BoxDecoration(
          color: Colors.teal.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Image.network(imageUrl, width: 60, height: 60),
          ],
        ),
      ),
    );
  }
}
