import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:ui/widgets/my_snackbar.dart';

class SubmitTugasController extends GetxController {
  var isLoading = false.obs;

  Future<void> postTugas({
    required String tugasId,
    String? text,
    File? file,
  }) async {
    log(tugasId.toString());
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final nisn = prefs.getString('nisn');

    if (token == null) {
      throw Exception("Token not found");
    }

    try {
      isLoading(true);

      var uri = Uri.parse(ApiConstants.submitTugasEnpoint);
      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = 'Bearer $token';

      request.fields['tugas_id'] = tugasId;
      request.fields['nisn'] = nisn!;

      if (text != null && text.isNotEmpty) {
        request.fields['text'] = text;
      }

      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath('file', file.path));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        Get.back(result: true);
        snackbarSuccess("Berhasil mengirim tugas");
      } else {
        log("Submit error: ${response.statusCode} ${response.body}");
        snackbarfailed("Gagal mengirim tugas");
      }
    } catch (e) {
      log("Submit Exception: $e");
      snackbarfailed("Terjadi kesalahan saat submit");
    } finally {
      isLoading(false);
    }
  }
}
