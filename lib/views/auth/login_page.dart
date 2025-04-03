import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/controllers/auth_controller.dart';
import 'package:ui/routes/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String role;
  late String idFieldLabel;
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
        return "NIS Siswa";
      case "guru":
        return "Email Guru";
      case "admin":
        return "Email Admin";
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
                  controller: idController,
                  decoration: _inputDecoration(idFieldLabel)),
              const SizedBox(height: 24.0),
              TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: _inputDecoration("Kata Sandi")),
              const SizedBox(height: 16.0),
              // Show error message if any
              Obx(() => authController.errorMessage.value.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        authController.errorMessage.value,
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  : const SizedBox.shrink()),
              const SizedBox(height: 8.0),
              Obx(() => authController.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () => _handleLogin(),
                      child: const Text("Masuk"),
                    )),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogin() async {
    if (idController.text.isEmpty || passwordController.text.isEmpty) {
      authController.errorMessage.value = 'Harap isi semua field';
      return;
    }

    final success = await authController.login(
      idController.text,
      passwordController.text,
    );

    print("Login result: $success");
    print("User role: ${authController.roleUser.value}");

    if (success) {
      // Route based on user role
      final destination = authController.getRedirectRouteBasedOnRole();
      print("Navigating to: $destination");
      
      // Use this navigation approach for better flow
      Get.offAllNamed(destination);
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
        labelText: label,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)));
  }
}