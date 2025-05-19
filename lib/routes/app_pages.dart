import 'package:ui/views/guru/dashboard/bindings/dashboard_binding.dart';
import 'package:ui/views/guru/mata_pelajaran/bindings/matpel_guru_binding.dart';
import 'package:ui/views/guru/mata_pelajaran/index.dart';
import 'package:ui/views/guru/profiles/index.dart';
import 'package:ui/views/guru/quiz/bindings/matpel_quiz_guru_binding.dart';
import 'package:ui/views/guru/quiz/bindings/quiz_detail_guru_binding.dart';
import 'package:ui/views/guru/quiz/bindings/quiz_guru_binding.dart';
import 'package:ui/views/guru/quiz/index.dart';
import 'package:ui/views/guru/quiz/quiz.dart';
import 'package:ui/views/guru/quiz/quiz_detail.dart';
import 'package:ui/views/guru/tugas/bindings/detail_submit_tugas_siswa_binding.dart';
import 'package:ui/views/guru/tugas/bindings/tugas_detail_guru_binding.dart';
import 'package:ui/views/guru/tugas/bindings/tugas_guru_binding.dart';
import 'package:ui/views/guru/tugas/detail.dart';
import 'package:ui/views/guru/tugas/detail_submit_tugas.dart';
import 'package:ui/views/guru/tugas/index.dart';
import 'package:ui/views/guru/tugas/review_submit_tugas.dart';
import 'package:ui/views/siswa/bindings/notifikasi_binding.dart';
import 'package:ui/views/siswa/bindings/ubah_password_binding.dart';
import 'package:ui/views/siswa/profile.dart';
import 'package:ui/views/siswa/quiz/bindings/matpel_quiz_binding.dart';
import 'package:ui/views/siswa/quiz/bindings/quiz_binding.dart';
import 'package:ui/views/siswa/quiz/bindings/quiz_finish_binding.dart';
import 'package:ui/views/siswa/quiz/bindings/soal_quiz_binding.dart';
import 'package:ui/views/siswa/quiz/matpel_quiz.dart';
import 'package:ui/views/siswa/quiz/matpel_quiz_detail.dart';
import 'package:ui/views/siswa/quiz/soal_quiz.dart';
import 'package:ui/views/siswa/quiz/soal_quiz_selesai.dart';
import 'package:ui/views/siswa/ranking/bindings/matpel_rank_binding.dart';
import 'package:ui/views/siswa/ranking/bindings/quiz_rank_binding.dart';
import 'package:ui/views/siswa/ranking/bindings/ranking_binding.dart';
import 'package:ui/views/siswa/ranking/index.dart';
import 'package:ui/views/siswa/ranking/matpel_rank.dart';
import 'package:ui/views/siswa/ranking/matpel_rank_detail.dart';
import 'package:ui/views/siswa/ubah_password.dart';

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
      middlewares: [AuthMiddleware()],
      binding: SiswaBinding(),
    ),
    GetPage(
      name: AppRoutes.notifikasiSiswa,
      page: () => NotifSiswa(),
      middlewares: [AuthMiddleware()],
      binding: NotifikasiBinding(),
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
    GetPage(
      name: AppRoutes.matpelQuiz,
      page: () => MatpelQuiz(),
      binding: MatpelQuizBinding(),
    ),
    GetPage(
      name: AppRoutes.matpelQuizDetail,
      page: () => MatpelQuizDetail(),
      binding: QuizBinding(),
    ),
    GetPage(
      name: AppRoutes.soalQuiz,
      page: () => const SoalQuiz(),
      binding: SoalQuizBinding(),
    ),
    GetPage(
      name: AppRoutes.quizSelesai,
      page: () => SoalQuizSelesai(),
      binding: QuizFinishBinding(),
    ),

    GetPage(
      name: AppRoutes.matpelRankQuiz,
      page: () => MatpelRank(),
      binding: MatpelRankBinding(),
    ),
    GetPage(
      name: AppRoutes.matpelQuizRankDetail,
      page: () => MatpelRankDetail(),
      binding: QuizRankBinding(),
    ),
    GetPage(
      name: AppRoutes.rankSiswa,
      page: () => RankSiswa(),
      binding: RankingBinding(),
    ),

    GetPage(
      name: AppRoutes.profileSiswa,
      page: () => ProfileSiswa(),
    ),
    GetPage(
      name: AppRoutes.ubahPassord,
      page: () => const UbahPasswordPage(),
      binding: UbahPasswordBinding(),
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
    GetPage(
      name: AppRoutes.detailSubmitTugasDetailGuru,
      page: () => const DetailSubmitTugas(),
      binding: DetailSubmitTugasSiswaBinding(),
    ),
    GetPage(
      name: AppRoutes.reviewSubmitTugasSiswaOnGuru,
      page: () => const ReviewSubmitTugas(),
      // binding: DetailSubmitTugasSiswaBinding(),
    ),
    GetPage(
      name: AppRoutes.mataPelajaranQuizGuru,
      page: () => const MataPelajaranQuizGuru(),
      binding: MatpelQuizGuruBinding(),
    ),
    GetPage(
      name: AppRoutes.quizGuru,
      page: () => QuizGuru(),
      binding: QuizGuruBinding(),
    ),
    GetPage(
      name: AppRoutes.quizDetailGuru,
      page: () => QuizDetailGuru(),
      binding: QuizDetailGuruBinding(),
    ),
  ];
}
