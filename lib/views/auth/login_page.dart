import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/views/auth/controllers/auth_controller.dart';
import 'dart:math' as math;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late String role;
  late String idFieldLabel;
  final AuthController authController = Get.find<AuthController>();
  late AnimationController _controller;
  late Animation<double> _animation;

  final Map<String, String> roleImages = {
    "siswa": "https://cdn-icons-png.flaticon.com/512/201/201818.png",
    "guru": "https://cdn-icons-png.flaticon.com/512/1995/1995574.png",
    "admin": "https://cdn-icons-png.flaticon.com/512/2206/2206368.png",
  };

  @override
  void initState() {
    super.initState();
    role = (Get.arguments is String) ? Get.arguments as String : "siswa";
    idFieldLabel = getIdFieldLabel(role);

    _initializeAnimation();
  }

  void _initializeAnimation() {
    if (!mounted) return;

    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    if (mounted) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String getIdFieldLabel(String role) {
    switch (role.toLowerCase()) {
      case "siswa":
        return "NIS atau Email Siswa";
      case "guru":
        return "Email atau Nip Guru";
      default:
        return "ID";
    }
  }

  Widget _buildAnimatedShapes() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        if (!mounted) return const SizedBox.shrink();

        return Stack(
          children: [
            // Shape 1
            Positioned(
              left: math.sin(_animation.value * 2 * math.pi) * 50 +
                  Get.width * 0.1,
              top: math.cos(_animation.value * 2 * math.pi) * 50 +
                  Get.height * 0.1,
              child: Transform.rotate(
                angle: _animation.value * 2 * math.pi,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(157, 157, 136, 0.1),
                        Color.fromRGBO(33, 198, 41, 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            // Shape 2
            Positioned(
              right: math.cos(_animation.value * 2 * math.pi) * 50 +
                  Get.width * 0.1,
              top: math.sin(_animation.value * 2 * math.pi) * 50 +
                  Get.height * 0.2,
              child: Transform.rotate(
                angle: -_animation.value * 2 * math.pi,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(157, 157, 136, 0.1),
                        Color.fromRGBO(33, 198, 41, 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F7F4),
      body: Stack(
        children: [
          // Animated Background Shapes
          _buildAnimatedShapes(),

          // Main Content
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.network(
                            roleImages[role.toLowerCase()]!,
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            role.capitalizeFirst ?? role,
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                          const SizedBox(height: 32.0),
                          TextField(
                            controller: authController.loginC,
                            decoration: _inputDecoration(idFieldLabel),
                          ),
                          const SizedBox(height: 24.0),
                          TextField(
                            controller: authController.passwordC,
                            obscureText: true,
                            decoration: _inputDecoration("Kata Sandi"),
                          ),
                          const SizedBox(height: 32.0),
                          Obx(() => authController.isLoading.value
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFF2E7D32)),
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    authController.login();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2E7D32),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: const Text(
                                    "Masuk",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(color: Color(0xFF2E7D32)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 2),
      ),
      labelStyle: TextStyle(color: Colors.grey.shade600),
    );
  }
}
