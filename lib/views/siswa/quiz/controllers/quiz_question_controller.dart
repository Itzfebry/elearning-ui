import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:ui/models/quiz_question_model.dart';
import 'package:http/http.dart' as http;

class QuizQuestionController extends GetxController {
  var isLoading = false.obs;
  QuizQuestionModel? quizQuestionM;

  Future<void> getQuizQuestion(attemptId) async {
    var url =
        "${ApiConstants.baseUrlApi}/quiz-attempts/$attemptId/next-question";

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
        Uri.parse(url),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        log(json.toString());
        quizQuestionM = QuizQuestionModel.fromJson(json);
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
