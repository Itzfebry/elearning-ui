import 'constansts_export.dart';

class ApiConstants {
  static String? baseUrl = dotenv.env['HOST'];
  static String klsMatpelEnpoint = "$baseUrl/kelasmatapelajarans";
  static String userEnpoint = "$baseUrl/users";
}
