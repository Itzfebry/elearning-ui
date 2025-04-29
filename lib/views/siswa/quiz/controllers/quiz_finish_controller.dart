import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:ui/constans/api_constans.dart';
import 'package:ui/models/quiz_attempt_model.dart';

class QuizFinishController extends GetxController {
  var isLoading = false.obs;
  QuizAttemptModel? quizAttemptM;

  @override
  void onInit() {
    super.onInit();
    var quizId = Get.arguments['quiz_id'];
    getQuizAttempt(quizId);
  }

  Future<void> getQuizAttempt(quizId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    await prefs.remove('attempt_id');

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
        Uri.parse("${ApiConstants.quizAttemptFinishEnpoint}?quiz_id=$quizId"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        quizAttemptM = QuizAttemptModel.fromJson(json);
      } else {
        log("Terjadi kesalahan get data attempt: ${response.statusCode}");
      }
    } catch (e) {
      log("Error get quiz attempt simple: $e");
    } finally {
      isLoading(false);
    }
  }
}
