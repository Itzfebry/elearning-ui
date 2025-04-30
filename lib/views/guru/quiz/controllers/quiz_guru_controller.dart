import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:ui/models/quiz_guru_model.dart';
import 'package:http/http.dart' as http;

class QuizGuruController extends GetxController {
  var isLoading = false.obs;
  QuizGuruModel? quizGuruM;
  var isEmptyData = true.obs;

  @override
  void onInit() {
    super.onInit();
    var id = Get.arguments['id'];
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
            "${ApiConstants.quizGuruEnpoint}?matapelajaran_id=$id&kelas=$kelas&tahun_ajaran=$tahunAjaran"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final json = await jsonDecode(response.body);
        log(json.toString());
        quizGuruM = QuizGuruModel.fromJson(json);
        if (quizGuruM!.data.isEmpty) {
          isEmptyData(true);
        } else {
          isEmptyData(false);
        }
      } else {
        log("Terjadi kesalahan get data quiz guru: ${response.statusCode}");
      }
    } catch (e) {
      log("Error get quiz guru: $e");
    } finally {
      isLoading(false);
    }
  }
}
