import 'package:get/get.dart';
import 'package:ui/middlewares/auth_middleware.dart';
import 'package:ui/views/auth/bindings/auth_binding.dart';
import 'package:ui/views/auth/login_page.dart';
import 'package:ui/views/common/splash_screen.dart';
import 'package:ui/views/common/welcome_page.dart';
import 'package:ui/views/common/selection_page.dart';
import 'package:ui/views/guru/guruDashboard.dart';
import 'package:ui/views/siswa/bindings/siswa_binding.dart';
import 'package:ui/views/siswa/matapelajaran/bindings/mata_pelajaran_binding.dart';
import 'package:ui/views/siswa/matapelajaran/mata_pelajaran.dart';
import 'package:ui/views/siswa/materi/bindings/materi_binding.dart';
import 'package:ui/views/siswa/materi/index.dart';
import 'package:ui/views/siswa/notifikasi.dart';
import 'package:ui/views/siswa/siswaDashboard.dart';
import 'package:ui/views/siswa/tugas/bindings/detail_tugas_binding.dart';
import 'package:ui/views/siswa/tugas/bindings/submit_tugas_binding.dart';
import 'package:ui/views/siswa/tugas/bindings/tugas_binding.dart';
import 'package:ui/views/siswa/tugas/tugas.dart';
import 'package:ui/views/siswa/tugas/tugas_commit.dart';
import 'package:ui/views/siswa/tugas/tugas_detail.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.welcome, page: () => const WelcomePage()),
    GetPage(name: AppRoutes.selection, page: () => const SelectionPage()),
    GetPage(
        name: AppRoutes.login,
        page: () => const LoginPage(),
        binding: AuthBinding()),
    GetPage(
      name: AppRoutes.siswaDashboard,
      page: () => const SiswaDashboardPage(),
      middlewares: [AuthMiddleware()], // AuthMiddleware for siswaDashboard
      binding: SiswaBinding(),
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
      name: AppRoutes.kelasmatapelajarans,
      page: () => KelasMataPelajaranPage(),
      binding: MataPelajaranBinding(),
    ),
    GetPage(
      name: AppRoutes.materiSiswa,
      page: () => const MateriView(),
      binding: MateriBinding(),
    ),
    GetPage(
      name: AppRoutes.tugasSiswa,
      page: () => Tugas(),
      binding: TugasBinding(),
    ),
    GetPage(
      name: AppRoutes.tugasDetailSiswa,
      page: () => const TugasDetail(),
      binding: DetailTugasBinding(),
    ),
    GetPage(
      name: AppRoutes.tugasCommitSiswa,
      page: () => const TugasCommit(),
      binding: SubmitTugasBinding(),
    ),
  ];
}
