// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/siswa/controllers/siswa_controller.dart';
import 'package:ui/widgets/my_text.dart';
import 'dart:math' as math;
import 'dart:ui';
import 'package:ui/views/guru/dashboard/controllers/dashboard_guru_controller.dart';
import 'package:flutter/rendering.dart';

class GuruDashboardPage extends StatefulWidget {
  const GuruDashboardPage({super.key});

  @override
  State<GuruDashboardPage> createState() => _GuruDashboardPageState();
}

class _GuruDashboardPageState extends State<GuruDashboardPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final DashboardGuruController dashboardC = Get.put(DashboardGuruController());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getRainbowColor(double value) {
    final hue = (value * 360) % 360;
    return HSLColor.fromAHSL(1.0, hue, 0.7, 0.5).toColor();
  }

  Widget _buildMenuTitle() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final rainbowColor = _getRainbowColor(_animation.value);
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: rainbowColor.withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: 2,
              ),
              BoxShadow(
                color: rainbowColor.withOpacity(0.2),
                blurRadius: 8,
                spreadRadius: -2,
              ),
            ],
          ),
          child: MyText(
            text: "Menu",
            fontSize: 18,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final glowColor =
            HSLColor.fromColor(color).withLightness(0.7).toColor();
        final innerGlowColor =
            HSLColor.fromColor(color).withLightness(0.8).toColor();

        return Container(
          height: 110,
          margin: const EdgeInsets.only(bottom: 5),
          child: InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                        glowColor.withOpacity(0.3 + (_animation.value * 0.2)),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: innerGlowColor
                        .withOpacity(0.2 + (_animation.value * 0.1)),
                    blurRadius: 8,
                    spreadRadius: -2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          color.withOpacity(0.2),
                          color.withOpacity(0.05),
                        ],
                        stops: const [0.0, 1.0],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: color.withOpacity(0.2),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Icon(
                            icon,
                            color: color,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 8),
                        MyText(
                          text: title,
                          fontSize: 15,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final SiswaController siswaC = Get.find<SiswaController>();

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            color: const Color.fromARGB(255, 255, 255, 255),
          ),

          // Animated Shapes
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Stack(
                children: [
                  // Shape 1
                  Positioned(
                    left: math.sin(_animation.value * 2 * math.pi) * 100 +
                        Get.width * 0.2,
                    top: math.cos(_animation.value * 2 * math.pi) * 100 +
                        Get.height * 0.2,
                    child: Transform.rotate(
                      angle: _animation.value * 2 * math.pi,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF81C784).withOpacity(0.3),
                              const Color(0xFF66BB6A).withOpacity(0.2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  // Shape 2
                  Positioned(
                    right: math.cos(_animation.value * 2 * math.pi) * 100 +
                        Get.width * 0.2,
                    top: math.sin(_animation.value * 2 * math.pi) * 100 +
                        Get.height * 0.3,
                    child: Transform.rotate(
                      angle: -_animation.value * 2 * math.pi,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF66BB6A).withOpacity(0.3),
                              const Color(0xFF4CAF50).withOpacity(0.2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ),
                  // Shape 3
                  Positioned(
                    left: math.cos(_animation.value * 2 * math.pi) * 150 +
                        Get.width * 0.3,
                    bottom: math.sin(_animation.value * 2 * math.pi) * 150 +
                        Get.height * 0.2,
                    child: Transform.rotate(
                      angle: _animation.value * 4 * math.pi,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF4CAF50).withOpacity(0.3),
                              const Color(0xFF43A047).withOpacity(0.2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(35),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Main Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: const [
                        Color.fromRGBO(157, 157, 136, 0),
                        Color.fromRGBO(33, 198, 41, 1),
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const MyText(
                                text: "Selamat Datang,",
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              const SizedBox(height: 5),
                              Obx(() {
                                if (dashboardC.isLoading.value) {
                                  return const MyText(
                                    text: "Loading...",
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  );
                                }
                                return MyText(
                                  text: dashboardC.dataUser.value?['data']
                                          ?['user']?['nama'] ??
                                      "Guru",
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Menu Section
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMenuTitle(),
                      const SizedBox(height: 10),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.1,
                        children: [
                          _buildMenuCard(
                            icon: Icons.assignment,
                            title: "Tugas",
                            color: Colors.blue,
                            onTap: () => Get.toNamed(AppRoutes.tugasGuru),
                          ),
                          _buildMenuCard(
                            icon: Icons.quiz,
                            title: "Quiz",
                            color: Colors.orange,
                            onTap: () =>
                                Get.toNamed(AppRoutes.mataPelajaranQuizGuru),
                          ),
                          _buildMenuCard(
                            icon: Icons.class_,
                            title: "Kelas",
                            color: Colors.purple,
                            onTap: () => Get.toNamed(AppRoutes.guruMatpel),
                          ),
                          _buildMenuCard(
                            icon: Icons.person,
                            title: "Profil",
                            color: Colors.teal,
                            onTap: () => Get.toNamed(AppRoutes.profileguru),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
