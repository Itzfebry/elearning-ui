import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:ui/models/quiz_mode.dart';

class QuizController extends GetxController {
  var isLoading = false.obs;
  QuizModel? quizM;
  var isEmptyData = true.obs;

  @override
  void onInit() {
    super.onInit();
    getQuiz();
  }

  Future<void> getQuiz() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    log(Get.arguments.toString());

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
            "${ApiConstants.quizEnpoint}?matapelajaran_id=${Get.arguments['id'].toString()}"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        log(json.toString());
        quizM = QuizModel.fromJson(json);
        if (quizM!.data.isEmpty) {
          isEmptyData(true);
        } else {
          isEmptyData(false);
        }
      } else {
        log("Terjadi kesalahan get data: ${response.statusCode}");
      }
    } catch (e) {
      log("Error get quiz simple: $e");
    } finally {
      isLoading(false);
    }
  }
}
