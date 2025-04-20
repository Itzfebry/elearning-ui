// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/views/siswa/controllers/siswa_controller.dart';

class ProfileGuruPage extends StatefulWidget {
  const ProfileGuruPage({super.key});

  @override
  State<ProfileGuruPage> createState() => _ProfileGuruPageState();
}

class _ProfileGuruPageState extends State<ProfileGuruPage> {
  SiswaController siswaC = Get.find<SiswaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Profil Guru')),
        body: Obx(
          () {
            if (siswaC.isLoading.value) {
              return const CircularProgressIndicator();
            }
            var data = siswaC.dataUser;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        'https://cdn.builder.io/api/v1/image/assets/7269843b34254a84ac205c1bfd7d31c3/85a37fd6b502cfa6f311cf6cb4af2f561dfa7c5fcbfb1afdd620a50cbfe97ea1?apiKey=7269843b34254a84ac205c1bfd7d31c3&'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    data['user']['nama'],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildInfoTile(title: "NIP", value: data['user']['nip']),
                  _buildInfoTile(
                      title: "Email", value: data['user']['user']['email']),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await siswaC.logout(role: "guru");
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

  Widget _buildInfoTile({required String title, required String value}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(color: Colors.grey)),
      subtitle: Text(value, style: const TextStyle(fontSize: 16)),
    );
  }
}
