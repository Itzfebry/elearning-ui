import 'package:get/get.dart';
import 'package:ui/bindings/kelasmatapelajarans_bindings.dart';
import 'package:ui/middlewares/auth_middleware.dart';
import 'package:ui/views/admin/adminDashboard.dart';
import 'package:ui/views/auth/login_page.dart';
import 'package:ui/views/common/splash_screen.dart';
import 'package:ui/views/common/welcome_page.dart';
import 'package:ui/views/common/selection_page.dart';
import 'package:ui/views/guru/guruDashboard.dart';
import 'package:ui/views/siswa/matapelajaran/mata_pelajaran.dart';
import 'package:ui/views/siswa/notifikasi.dart';
import 'package:ui/views/siswa/siswaDashboard.dart';
import 'package:ui/bindings/auth_binding.dart'; // Import AuthBinding
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
    GetPage(name: AppRoutes.welcome, page: () => const WelcomePage()),
    GetPage(name: AppRoutes.selection, page: () => const SelectionPage()),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: AuthBinding(), // AuthBinding for login page
    ),
    GetPage(
      name: AppRoutes.siswaDashboard,
      page: () => const SiswaDashboardPage(),
      middlewares: [AuthMiddleware()], // AuthMiddleware for siswaDashboard
      binding: AuthBinding(), // Binding for AuthController
    ),
    GetPage(
      name: AppRoutes.notifikasiSiswa,
      page: () => const NotifSiswa(),
      middlewares: [AuthMiddleware()], // AuthMiddleware for siswaDashboard
      // binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.guruDashboard,
      page: () => const GuruDashboardPage(),
      middlewares: [AuthMiddleware()], // AuthMiddleware for guruDashboard
      binding: AuthBinding(), // Binding for AuthController
    ),
    GetPage(
      name: AppRoutes.adminDashboard,
      page: () => const AdminDashboardPage(),
      middlewares: [AuthMiddleware()], // AuthMiddleware for adminDashboard
      binding: AuthBinding(), // Binding for AuthController
    ),
    GetPage(
      name: AppRoutes.kelasmatapelajarans,
      page: () => KelasMataPelajaranPage(),
      binding: KelasMataPelajaranBinding(),
    ),
  ];
}
