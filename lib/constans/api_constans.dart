import 'constansts_export.dart';

class ApiConstants {
  static String? baseUrl = dotenv.env['HOST'];
  static String loginEnpoint = "$baseUrl/login";

  static String klsMatpelEnpoint = "$baseUrl/kelasmatapelajarans";
  static String userEnpoint = "$baseUrl/users";
}
