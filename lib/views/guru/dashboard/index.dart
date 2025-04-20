// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/siswa/controllers/siswa_controller.dart';
import 'package:ui/widgets/my_snackbar.dart';

class GuruDashboardPage extends StatelessWidget {
  final List<MenuItem> items = [
    MenuItem(
        title: "Mata Pelajaran",
        color: Colors.deepOrange,
        icon: Icons.lightbulb),
    MenuItem(title: "Tugas", color: Colors.blueAccent, icon: Icons.science),
    MenuItem(title: "Quiz", color: Colors.indigo, icon: Icons.public),
    MenuItem(title: "Profile", color: Colors.orangeAccent, icon: Icons.person),
  ];

  GuruDashboardPage({super.key});
  SiswaController siswaC = Get.find<SiswaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "E-Learning",
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
              Obx(() {
                var data = siswaC.dataUser['user'];
                if (siswaC.isLoading.value) {
                  return const CircularProgressIndicator();
                } else {
                  return Text(
                    "Hi, ${data?['nama']}",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  );
                }
              }),
              const SizedBox(height: 32),
              Expanded(
                child: GridView.builder(
                  itemCount: items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Get.toNamed(AppRoutes.guruMatpel);
                            break;
                          case 1:
                            Get.toNamed(AppRoutes.tugasGuru);
                            break;
                          case 2:
                            Get.toNamed(AppRoutes.guruMatpel);
                            break;
                          case 3:
                            Get.toNamed(AppRoutes.profileguru);
                            break;
                          default:
                            snackbarfailed("Tidak ada fitur lagi");
                        }
                        // if (index == 0) {
                        //   Get.to(AppRoutes.guruMatpel);
                        // }else if(index == )
                      },
                      child: buildMenuCard(items[index]),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuCard(MenuItem item) {
    return Container(
      decoration: BoxDecoration(
        color: item.color,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(item.icon, size: 48, color: Colors.white),
          const SizedBox(height: 16),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          )
        ],
      ),
    );
  }
}

class MenuItem {
  final String title;
  final Color color;
  final IconData icon;

  MenuItem({
    required this.title,
    required this.color,
    required this.icon,
  });
}
