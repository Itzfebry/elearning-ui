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
  var skorMe = "".obs;

  @override
  void onInit() {
    super.onInit();
    var quizId = Get.arguments['quiz_id'];
    getQuizAttempt(quizId);
    getSkorMe(quizId);
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

  // Method untuk mengambil skor yang sama seperti di ranking
  Future<void> getSkorMe(quizId) async {
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
      final response = await http.get(
        Uri.parse("${ApiConstants.quizTopFiveEnpoint}?quiz_id=$quizId"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        skorMe.value = json['skor_me']['skor'];
      } else {
        log("Terjadi kesalahan get skor me: ${response.statusCode}");
      }
    } catch (e) {
      log("Error get skor me: $e");
    }
  }

  // Method untuk manually finish quiz
  Future<void> finishQuiz(String quizId) async {
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
      log("Manually finishing quiz for quiz ID: $quizId");

      // Use POST method for finishing quiz
      final response = await http.post(
        Uri.parse("${ApiConstants.quizAttemptFinishEnpoint}?quiz_id=$quizId"),
        headers: headers,
      );

      log("Manual finish response status: ${response.statusCode}");
      log("Manual finish response body: ${response.body}");

      if (response.statusCode == 200) {
        log("Quiz finished successfully");
        // Refresh the data
        await getQuizAttempt(quizId);
      } else {
        log("Failed to finish quiz: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      log("Error manually finishing quiz: $e");
    }
  }
}
