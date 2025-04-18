import 'constansts_export.dart';

class ApiConstants {
  static String? baseUrl = dotenv.env['URL'];
  static String? baseUrlApi = "${dotenv.env['HOST']}";
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
}
