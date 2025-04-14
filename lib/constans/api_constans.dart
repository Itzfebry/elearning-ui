import 'constansts_export.dart';

class ApiConstants {
  static String? baseUrl = dotenv.env['HOST'];
  static String loginEnpoint = "$baseUrl/login";
  static String logoutEnpoint = "$baseUrl/logout";

  static String klsMatpelEnpoint = "$baseUrl/kelasmatapelajarans";
  static String getMeEnpoint = "$baseUrl/get-me";
}
