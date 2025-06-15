import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'dart:math' show Random;
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/siswa/controllers/notifikasi_count_controller.dart';
import 'package:ui/views/siswa/controllers/siswa_controller.dart';
import 'package:ui/widgets/my_text.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Shape> _shapes = [];
  final int _numberOfShapes = 4;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();

    // Initialize shapes with random angles and distances
    for (int i = 0; i < _numberOfShapes; i++) {
      _shapes.add(Shape(
        angle: _random.nextDouble() * math.pi * 2,
        distance: 150 + _random.nextDouble() * 250,
        baseSize: 150 + _random.nextDouble() * 200,
        speed: 0.1 + _random.nextDouble() * 0.2,
        type: _random.nextBool() ? ShapeType.curve : ShapeType.triangle,
        opacity: 0.1,
        opacitySpeed: 0.1 + _random.nextDouble() * 0.3,
        sizeSpeed: 0.2 + _random.nextDouble() * 0.3,
        angleSpeed: 0.05 + _random.nextDouble() * 0.2,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: BackgroundPainter(
            shapes: _shapes,
            animation: _controller.value,
          ),
          child: Container(),
        );
      },
    );
  }
}

class Shape {
  double angle;
  double distance;
  double size;
  final double baseSize;
  final double speed;
  final ShapeType type;
  double opacity;
  double opacitySpeed;
  double sizeSpeed;
  double angleSpeed;

  Shape({
    required this.angle,
    required this.distance,
    required this.baseSize,
    required this.speed,
    required this.type,
    required this.opacity,
    required this.opacitySpeed,
    required this.sizeSpeed,
    required this.angleSpeed,
  }) : size = baseSize;
}

enum ShapeType {
  curve,
  triangle,
}

class BackgroundPainter extends CustomPainter {
  final List<Shape> shapes;
  final double animation;

  BackgroundPainter({
    required this.shapes,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    for (var shape in shapes) {
      try {
        // Update opacity with sine wave for smooth fading
        shape.opacity = 0.1 +
            (math.sin(animation * math.pi * 2 * shape.opacitySpeed) * 0.15);
        shape.opacity =
            shape.opacity.clamp(0.0, 1.0); // Ensure opacity is between 0 and 1

        // Update size with sine wave for pulsing effect
        shape.size = shape.baseSize *
            (0.8 + (math.sin(animation * math.pi * 2 * shape.sizeSpeed) * 0.3));
        shape.size =
            shape.size.clamp(1.0, double.infinity); // Ensure size is positive

        // Update angle for rotation with varying speed
        shape.angle += shape.angleSpeed * 0.02;

        final paint = Paint()
          ..color = Colors.green.withOpacity(shape.opacity)
          ..style = PaintingStyle.fill
          ..isAntiAlias = true;

        // Calculate position based on angle and distance from center
        final x = centerX + math.cos(shape.angle) * shape.distance;
        final y = centerY + math.sin(shape.angle) * shape.distance;

        // Ensure coordinates are within bounds
        if (x.isFinite && y.isFinite) {
          // Draw shape based on type
          final path = Path();
          if (shape.type == ShapeType.curve) {
            path
              ..moveTo(x, y)
              ..quadraticBezierTo(
                x + shape.size * 0.5,
                y - shape.size * 0.5,
                x + shape.size,
                y,
              )
              ..quadraticBezierTo(
                x + shape.size * 1.5,
                y + shape.size * 0.5,
                x,
                y,
              );
          } else {
            // Triangle
            final triangleSize = shape.size * 1.2;
            path
              ..moveTo(x, y - triangleSize)
              ..lineTo(x + triangleSize, y + triangleSize * 0.5)
              ..lineTo(x - triangleSize, y + triangleSize * 0.5)
              ..close();
          }

          canvas.drawPath(path, paint);
        }
      } catch (e) {
        debugPrint('Error painting shape: $e');
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

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
        onTap: () => Get.toNamed(AppRoutes.profileSiswa),
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
        onTap: () => Get.toNamed(AppRoutes.notifikasiSiswa)?.then((_) {
          siswaC.getMe();
          notifC.getNotifCount();
        }),
      ),
    ];

    // return WillPopScope(
    //   onWillPop: () async {
    // return snackbarAlert("a", "Klik 2x untuk keluar", Colors.black);
    //     final shouldLogout = await showDialog(
    //       context: context,
    //       builder: (context) => AlertDialog(
    //         title: const Text('Konfirmasi Logout'),
    //         content: const Text('Apakah anda ingin Logout?'),
    //         actions: [
    //           TextButton(
    //             onPressed: () => Navigator.of(context).pop(false),
    //             child: const Text('Batal'),
    //           ),
    //           TextButton(
    //             onPressed: () => Navigator.of(context).pop(true),
    //             child: const Text(
    //               'Logout',
    //               style: TextStyle(color: Colors.red),
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //     if (shouldLogout == true) {
    //       siswaC.logout(role: "siswa");
    //     }
    //     return false;
    // },
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          const AnimatedBackground(),
          SafeArea(
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
                        child: RefreshIndicator(
                          onRefresh: () {
                            notifC.getNotifCount();
                            siswaC.getMe();
                            return Future.value();
                          },
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
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // ),
        ],
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
