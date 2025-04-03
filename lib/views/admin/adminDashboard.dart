import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/controllers/auth_controller.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Admin'),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              bool confirmLogout = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Konfirmasi Logout'),
                    content: const Text('Apakah Anda yakin ingin keluar?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Logout', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  );
                },
              );

              if (confirmLogout == true) {
                authController.logout();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selamat Datang, Admin!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Card(
              child: ListTile(
                leading: const Icon(Icons.people, color: Colors.purple),
                title: const Text('Kelola Pengguna'),
                subtitle: const Text('Tambah, edit, atau hapus pengguna'),
                onTap: () {
                  // Navigasi ke halaman kelola pengguna
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.school, color: Colors.teal),
                title: const Text('Kelola Kelas'),
                subtitle: const Text('Tambah atau edit kelas'),
                onTap: () {
                  // Navigasi ke halaman kelola kelas
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.settings, color: Colors.blueGrey),
                title: const Text('Pengaturan Sistem'),
                subtitle: const Text('Kelola pengaturan aplikasi'),
                onTap: () {
                  // Navigasi ke halaman pengaturan
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
