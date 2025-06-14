import 'constansts_export.dart';

class ApiConstants {
  var idAttempt;

  static String? baseUrl = dotenv.env['URL'];
  static String? baseUrlApi = "${dotenv.env['HOST']}";
  // Tambahkan log untuk debugging konfigurasi URL
  static void debugApiUrls() {
    // ignore: avoid_print
    print("ApiConstants.baseUrl: $baseUrl");
    // ignore: avoid_print
    print("ApiConstants.baseUrlApi: $baseUrlApi");
    // ignore: avoid_print
    print("ApiConstants.loginEnpoint: $loginEnpoint");
  }

  static String loginEnpoint = "$baseUrlApi/login";
  static String logoutEnpoint = "$baseUrlApi/logout";

  static String klsMatpelEnpoint = "$baseUrlApi/kelasmatapelajarans";
  static String getMeEnpoint = "$baseUrlApi/get-me";
  static String getMateriEnpoint = "$baseUrlApi/get-materi";
  static String mataPelajaranEnpoint = "$baseUrlApi/get-mata-pelajaran";
  static String mataPelajaranSimpleEnpoint =
      "$baseUrlApi/get-mata-pelajaran-simple";
  static String tugasEnpoint = "$baseUrlApi/get-tugas";
  static String submitTugasEnpoint = "$baseUrlApi/submit-tugas";
  static String updateTugasEnpoint = "$baseUrlApi/update-tugas";

  static String kelasEnpoint = "$baseUrlApi/kelas";
  static String tahunAjaranEnpoint = "$baseUrlApi/tahun-ajaran";

  static String getDetailSubmitTugasSiswaEnpoint =
      "$baseUrlApi/get-submit-tugas-siswa";

  static String quizEnpoint = "$baseUrlApi/quiz";
  static String quizAttemptStartEnpoint = "$baseUrlApi/quiz-attempts/start";
  static String quizAttemptFinishEnpoint = "$baseUrlApi/quiz-attempts/finish";

  static String quizTopFiveEnpoint = "$baseUrlApi/quiz-top-five";
  static String quizGuruEnpoint = "$baseUrlApi/quiz-guru";
  static String quizDetailGuruEnpoint = "$baseUrlApi/get-quiz-attempt-guru";

  // Notifikasi
  static String notifikasiCountEnpoit = "$baseUrlApi/siswa/notifikasi/count";
  static String notifikasiEnpoit = "$baseUrlApi/siswa/notifikasi";

  // Ubah Password
  static String ubahPasswordEnpoint = "$baseUrlApi/change-password";

  // Ubah Password
  static String analysisSiswaEnpoint = "$baseUrlApi/analysis-siswa";

  static String checkToken = "$baseUrlApi/check-token";
}
