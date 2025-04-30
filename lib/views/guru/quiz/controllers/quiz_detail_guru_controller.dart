import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';

class QuizDetailGuruController extends GetxController {
  var isLoading = false.obs;
  var isEmptyData = true.obs;
  var data = [].obs;

  @override
  void onInit() {
    super.onInit();
    var id = Get.arguments['quiz_id'];
    var kelas = Get.arguments['kelas'];
    var tahunAjaran = Get.arguments['tahun_ajaran'];

    getQuiz(id, kelas, tahunAjaran);
  }

  Future<void> getQuiz(id, kelas, tahunAjaran) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception("Token not found");
    }
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse(
            "${ApiConstants.quizDetailGuruEnpoint}?quiz_id=$id&kelas=$kelas&tahun_ajaran=$tahunAjaran"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final json = await jsonDecode(response.body);
        data.value = json['data'];
        log(json.toString());
        if (json['data'].length == 0) {
          isEmptyData(true);
        } else {
          isEmptyData(false);
        }
      } else {
        log("Terjadi kesalahan get data quiz detail guru: ${response.statusCode}");
      }
    } catch (e) {
      log("Error get quiz detail guru: $e");
    } finally {
      isLoading(false);
    }
  }
}
