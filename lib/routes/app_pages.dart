import 'package:ui/views/guru/dashboard/bindings/dashboard_binding.dart';
import 'package:ui/views/guru/mata_pelajaran/bindings/matpel_guru_binding.dart';
import 'package:ui/views/guru/mata_pelajaran/index.dart';
import 'package:ui/views/guru/profiles/index.dart';
import 'package:ui/views/guru/tugas/bindings/tugas_detail_guru_binding.dart';
import 'package:ui/views/guru/tugas/bindings/tugas_guru_binding.dart';
import 'package:ui/views/guru/tugas/detail.dart';
import 'package:ui/views/guru/tugas/index.dart';

import 'app_routes.dart';
import 'export.dart';

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
      page: () => GuruDashboardPage(),
      middlewares: [AuthMiddleware()],
      binding: DashboardBinding(),
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

    // GURU
    GetPage(
      name: AppRoutes.guruMatpel,
      page: () => const MataPelajaranGuru(),
      binding: MatpelGuruBinding(),
    ),
    GetPage(
      name: AppRoutes.profileguru,
      page: () => const ProfileGuruPage(),
      binding: SiswaBinding(),
    ),
    GetPage(
      name: AppRoutes.tugasGuru,
      page: () => TugasGuruPage(),
      binding: TugasGuruBinding(),
    ),
    GetPage(
      name: AppRoutes.tugasDetailGuru,
      page: () => DetailTugasGuru(),
      binding: TugasDetailGuruBinding(),
    ),
  ];
}
