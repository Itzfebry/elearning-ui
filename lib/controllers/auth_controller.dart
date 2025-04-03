import 'package:get/get.dart';
import 'package:ui/services/auth_services.dart';
import 'package:ui/routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final namaUser = ''.obs;
  final roleUser = ''.obs;
  var isDialogShown = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final isLoggedIn = await _authService.isAuthenticated();
    
    if (isLoggedIn) {
      await getUserInfo();

      // Pastikan roleUser tidak kosong sebelum navigasi
      if (roleUser.value.isNotEmpty) {
        String redirectRoute = getRedirectRouteBasedOnRole();
        
        // 🔹 Hindari looping dengan mengecek apakah pengguna sudah di halaman tujuan
        if (Get.currentRoute != redirectRoute) {
          print("[GETX] Redirecting to: $redirectRoute");
          Get.offAllNamed(redirectRoute);
        }
      }
    } else {
      if (Get.currentRoute != AppRoutes.login) {
        print("[GETX] Redirecting to: ${AppRoutes.login}");
        Get.offAllNamed(AppRoutes.login);
      }
    }
  }

  Future<void> getUserInfo() async {
    try {
      final userData = await _authService.getUserData();
      namaUser.value = userData['name'] ?? '';
      roleUser.value = userData['role'] ?? '';
      print("[GETX] User Role: ${roleUser.value}");
    } catch (e) {
      print("Error getting user info: $e");
    }
  }

  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await _authService.login(email, password);
      if (result['success']) {
        namaUser.value = result['name'] ?? '';
        roleUser.value = result['role'] ?? '';

        // 🔹 Pastikan roleUser sudah di-set sebelum navigasi
        if (roleUser.value.isNotEmpty) {
          String redirectRoute = getRedirectRouteBasedOnRole();
          print("[GETX] Login Success. Redirecting to: $redirectRoute");
          Get.offAllNamed(redirectRoute);
        }

        return true;
      } else {
        errorMessage.value = result['message'] ?? 'Login gagal';
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan saat login';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void setDialogShown() {
    isDialogShown.value = true;
  }

  Future<void> logout() async {
    await _authService.logout();
    namaUser.value = '';
    roleUser.value = '';

    if (Get.currentRoute != AppRoutes.login) {
      print("[GETX] Logging out. Redirecting to: ${AppRoutes.login}");
      Get.offAllNamed(AppRoutes.login);
    }
  }

  String getRedirectRouteBasedOnRole() {
    switch (roleUser.value.toLowerCase()) {
      case 'siswa':
        return AppRoutes.siswaDashboard;
      case 'guru':
        return AppRoutes.guruDashboard;
      case 'admin':
        return AppRoutes.adminDashboard;
      default:
        return AppRoutes.login;
    }
  }
}
