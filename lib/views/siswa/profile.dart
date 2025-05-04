// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/siswa/controllers/siswa_controller.dart';

class ProfileSiswa extends StatelessWidget {
  ProfileSiswa({super.key});
  SiswaController siswaC = Get.find<SiswaController>();

  @override
  Widget build(BuildContext context) {
    final kelebihan = {
      'Matematika': 85,
      'Bahasa Inggris': 78,
    };

    final kekurangan = {
      'Fisika': 45,
      'Kimia': 50,
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Siswa'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(
              () => Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person, size: 50),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    siswaC.dataUser['user']['nama'],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Kelas ${siswaC.dataUser['user']['kelas']}',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    siswaC.dataUser['user']['user']['email'].toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const Divider(height: 32, thickness: 1),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Kelebihan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            ...kelebihan.entries.map(
              (entry) => ProgressItem(
                title: entry.key,
                percentage: entry.value,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Kekurangan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            ...kekurangan.entries.map(
              (entry) => ProgressItem(
                title: entry.key,
                percentage: entry.value,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Get.toNamed(AppRoutes.ubahPassord);
              },
              icon: const Icon(
                Icons.lock_reset,
                color: Colors.black,
              ),
              label: const Text(
                'Ubah Password',
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade200,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Konfirmasi Logout'),
                    content: const Text('Apakah Anda yakin ingin logout?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(); // Tutup dialog
                        },
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () {
                          siswaC.logout(role: "siswa");
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              label: const Text(
                'Logout',
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade300,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressItem extends StatelessWidget {
  final String title;
  final int percentage;
  final Color color;

  const ProgressItem({
    super.key,
    required this.title,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title ($percentage%)',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: percentage / 100,
            color: color,
            backgroundColor: color.withOpacity(0.2),
            minHeight: 8,
          ),
        ],
      ),
    );
  }
}
