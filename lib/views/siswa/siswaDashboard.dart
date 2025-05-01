import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/siswa/controllers/notifikasi_count_controller.dart';
import 'package:ui/views/siswa/controllers/siswa_controller.dart';
import 'package:ui/views/siswa/profile.dart';
import 'package:ui/widgets/my_text.dart';

class SiswaDashboardPage extends StatelessWidget {
  const SiswaDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final siswaC = Get.find<SiswaController>();
    final notifC = Get.find<NotifikasiCountController>();

    final List<_DashboardMenu> menuItems = [
      _DashboardMenu(
        title: "Mata Pelajaran",
        icon: Icons.menu_book_rounded,
        color: Colors.teal.shade300,
        onTap: () => Get.toNamed(AppRoutes.kelasmatapelajarans),
      ),
      _DashboardMenu(
        title: "#1 Ranking",
        icon: Icons.emoji_events_rounded,
        color: Colors.indigo.shade200,
        onTap: () => Get.toNamed(AppRoutes.matpelRankQuiz),
      ),
      _DashboardMenu(
        title: "Quiz",
        icon: Icons.quiz_rounded,
        color: Colors.green.shade300,
        onTap: () => Get.toNamed(AppRoutes.matpelQuiz),
      ),
      _DashboardMenu(
        title: "Profil",
        icon: Icons.person_rounded,
        color: Colors.amber.shade200,
        onTap: () => Get.to(const ProfileSiswa()),
      ),
      _DashboardMenu(
        title: "Tugas",
        icon: Icons.assignment_rounded,
        color: Colors.teal.shade400,
        onTap: () => Get.toNamed(AppRoutes.tugasSiswa),
      ),
      _DashboardMenu(
        title: "Notifikasi",
        icon: Icons.notifications_active_rounded,
        color: Colors.pink.shade200,
        onTap: () => Get.toNamed(AppRoutes.notifikasiSiswa),
      ),
    ];

    return WillPopScope(
      onWillPop: () async {
        final shouldLogout = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Konfirmasi Logout'),
            content: const Text('Apakah anda ingin Logout?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Batal'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
        if (shouldLogout == true) {
          siswaC.logout(role: "siswa");
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Obx(() {
                  if (siswaC.isLoading.value) {
                    return const CircularProgressIndicator();
                  }
                  var user = siswaC.dataUser['user'];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "E-Learning",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Hi, ${user?['nama'] ?? 'Siswa'}",
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Kelas : ${user?['kelas']}",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 30),

                // Menu Grid
                Obx(
                  () {
                    if (notifC.isLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        children: menuItems.map((item) {
                          return GestureDetector(
                            onTap: item.onTap,
                            child: Stack(
                              fit: StackFit.expand,
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: item.color,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(item.icon,
                                            size: 40, color: Colors.white),
                                        const SizedBox(height: 12),
                                        Text(
                                          item.title,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (item.title == "Notifikasi" &&
                                    notifC.notifCount.value > 0)
                                  Positioned(
                                    top: -7,
                                    right: -5,
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: MyText(
                                          text: notifC.notifCount.value
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardMenu {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  _DashboardMenu({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}
