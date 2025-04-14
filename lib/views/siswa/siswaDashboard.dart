import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/siswa/controllers/siswa_controller.dart';
import 'package:ui/views/siswa/profile.dart';
import 'package:ui/views/siswa/quiz.dart';
import 'package:ui/views/siswa/tugas/tugas.dart';
import 'package:ui/views/siswa/ranksiswa.dart';

class SiswaDashboardPage extends StatelessWidget {
  const SiswaDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final siswaC = Get.find<SiswaController>();

    return WillPopScope(
      onWillPop: () async {
        final shouldLogout = await showDialog(
          context: context,
          barrierColor: Colors.black54, // Warna latar belakang lebih transparan
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                'Konfirmasi Logout',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              content: const Text(
                'Apakah anda ingin Logout?',
                style: TextStyle(fontSize: 18),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'Batal',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        );

        if (shouldLogout == true) {
          siswaC.logout();
        }

        return false; // Mencegah navigasi back default
      },
      child: Scaffold(
        backgroundColor: Colors.teal[50],
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/dashboardsiswa.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    Container(
                      padding: const EdgeInsets.only(left: 30, top: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'E-Learning',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Obx(() {
                            if (siswaC.isLoading.value) {
                              return const CircularProgressIndicator();
                            }
                            var user = siswaC.dataUser['user'];
                            return Text(
                              'Hi, ${user?['nama']}',
                              style: const TextStyle(
                                fontSize: 32,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),

                    // Notification Icon
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.notifikasiSiswa);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.green.shade100,
                          radius: 30,
                          child: const Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Icon(Icons.notifications, color: Colors.black),
                              Positioned(
                                left: 10,
                                bottom: 10,
                                child: CircleAvatar(
                                  backgroundColor: Colors.yellow,
                                  radius: 8,
                                  child: Text(
                                    "10",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Card Layout Grid (Asymmetric)
                    Column(
                      children: [
                        // Row 1 (Upper Section)
                        Row(
                          children: [
                            // "Mata Pelajaran" Card
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.kelasmatapelajarans);
                              },
                              child: Container(
                                width: screenWidth * 0.45,
                                height: screenHeight * 0.15,
                                decoration: BoxDecoration(
                                  color: Colors.teal.shade300,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Stack(
                                  children: [
                                    // Positioned(
                                    //   top: 0,
                                    //   right: 0,
                                    //   child: Container(
                                    //     padding: const EdgeInsets.all(15),
                                    //     decoration: const BoxDecoration(
                                    //       color: Colors.yellow,
                                    //       shape: BoxShape.circle,
                                    //     ),
                                    //     child: const Text('1'),
                                    //   ),
                                    // ),
                                    Center(
                                      child: Text(
                                        'Mata Pelajaran',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10), // Spacing between cards

                            // Vertical Stack of "#1 Ranking" and "Ruang Diskusi"
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // "#1 Ranking" Card
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RankSiswa()),
                                    );
                                  },
                                  child: Container(
                                    width: screenWidth * 0.42,
                                    height: screenHeight * 0.15,
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey.shade100,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '#1',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.022),

                                // "Ruang Diskusi" Card
                                // GestureDetector(
                                //   onTap: () {
                                //     // Navigator.push(
                                //     //   context,
                                //     //   MaterialPageRoute(builder: (context) => ()),
                                //     // );
                                //   },
                                //   child: Container(
                                //     width: screenWidth * 0.37,
                                //     height: screenHeight * 0.2,
                                //     decoration: BoxDecoration(
                                //       color: Colors.green.shade400,
                                //       borderRadius: BorderRadius.circular(50),
                                //     ),
                                //     child: const Align(
                                //       alignment: Alignment.center,
                                //       child: Text(
                                //         'Ruang Diskusi',
                                //         style: TextStyle(
                                //             fontSize: 18,
                                //             fontWeight: FontWeight.bold),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20), // Spacing between rows

                        // Row 2 (Middle Section)
                        Row(
                          children: [
                            // "Quiz" Card
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const QuizSiswa()),
                                );
                              },
                              child: Container(
                                width: screenWidth * 0.55,
                                height: screenHeight * 0.12,
                                decoration: BoxDecoration(
                                  color: Colors.green.shade300,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Quiz',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(), // Spacing between cards

                            // "Profil Febry" Card
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileSiswa()),
                                );
                              },
                              child: Container(
                                width: screenWidth * 0.35,
                                height: screenHeight * 0.12,
                                decoration: BoxDecoration(
                                  color: Colors.yellow.shade100,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Profil Febry',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20), // Spacing between rows

                        // "Tugas" Card
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Tugas()),
                            );
                          },
                          child: Container(
                            width: screenWidth * 0.9,
                            height: screenHeight * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.teal.shade400,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Stack(
                              children: [
                                // Positioned(
                                //   top: 8,
                                //   right: 8,
                                //   child: Container(
                                //     padding: const EdgeInsets.all(8),
                                //     decoration: const BoxDecoration(
                                //       color: Colors.yellow,
                                //       shape: BoxShape.circle,
                                //     ),
                                //     child: const Text('2'),
                                //   ),
                                // ),
                                Center(
                                  child: Text(
                                    'Tugas',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
