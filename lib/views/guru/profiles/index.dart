// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/views/siswa/controllers/siswa_controller.dart';
import 'package:ui/widgets/my_text.dart';

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
      appBar: AppBar(
        title: const MyText(
          text: "Profil Guru",
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: const Color(0xFF57E389),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF57E389),
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Obx(
            () {
              if (siswaC.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              var data = siswaC.dataUser;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF57E389),
                            width: 2,
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            'https://cdn.builder.io/api/v1/image/assets/7269843b34254a84ac205c1bfd7d31c3/85a37fd6b502cfa6f311cf6cb4af2f561dfa7c5fcbfb1afdd620a50cbfe97ea1?apiKey=7269843b34254a84ac205c1bfd7d31c3&',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      MyText(
                        text: data['user']['nama'],
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 8),
                      MyText(
                        text: "Guru",
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 30),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _buildInfoTile(
                              icon: Icons.badge,
                              title: "NIP",
                              value: data['user']['nip'],
                            ),
                            const Divider(height: 1),
                            _buildInfoTile(
                              icon: Icons.email,
                              title: "Email",
                              value: data['user']['user']['email'],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            await siswaC.logout(role: "guru");
                          },
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                          label: const MyText(
                            text: 'Logout',
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF57E389).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF57E389),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: title,
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 4),
                MyText(
                  text: value,
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
