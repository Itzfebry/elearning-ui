import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/views/auth/controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String role;
  late String idFieldLabel;
  final AuthController authController = Get.find<AuthController>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F7F4),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(roleImages[role.toLowerCase()]!,
                  width: 100, height: 100),
              const SizedBox(height: 16.0),
              Text(role.capitalizeFirst ?? role,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.w500)),
              const SizedBox(height: 32.0),
              TextField(
                  controller: authController.loginC,
                  decoration: _inputDecoration(idFieldLabel)),
              const SizedBox(height: 24.0),
              TextField(
                  controller: authController.passwordC,
                  obscureText: true,
                  decoration: _inputDecoration("Kata Sandi")),
              const SizedBox(height: 16.0),
              const SizedBox(height: 8.0),
              Obx(() => authController.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        authController.login();
                      },
                      child: const Text("Masuk"),
                    )),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
        labelText: label,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)));
  }
}
