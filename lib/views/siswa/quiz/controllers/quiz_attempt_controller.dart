import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:ui/models/quiz_answer_model.dart';
import 'package:ui/views/siswa/quiz/controllers/quiz_question_controller.dart';
import 'package:ui/widgets/my_snackbar.dart';

class QuizAttemptController extends GetxController {
  var isLoadingAttempt = false.obs;
  var isLoadingAnswer = false.obs;
  var isCorrect = 0.obs;
  var isLastQuestion = false.obs;
  var quizId = "".obs;
  QuizAnswerModel? quizAnswerM;
  QuizQuestionController questionC = Get.find<QuizQuestionController>();

  @override
  void onInit() {
    super.onInit();
    var quizId = Get.arguments['quiz_id'];
    postQuizAttemptStart(quizId);
  }

  Future<void> postQuizAttemptStart(var quizId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final nisn = prefs.getString('nisn');

    if (token == null) {
      throw Exception("Token not found");
    }
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      isLoadingAttempt(true);
      Map body = {
        'quiz_id': quizId,
        'nisn': nisn,
      };
      final response = await http.post(
        Uri.parse(ApiConstants.quizAttemptStartEnpoint),
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        await prefs.setString('attempt_id', json['attempt_id'].toString());

        snackbarAlert(json['message'] ?? "Quiz",
            "Tidak boleh keluar dari quiz ini!.", Colors.green);

        log("attempt_id: ${json['attempt_id'].toString()}");
        questionC.getQuizQuestion(json['attempt_id']);
      } else {
        log("Terjadi kesalahan get data: ${response.statusCode}");
      }
    } catch (e) {
      log("Error get matpel simple: $e");
    } finally {
      isLoadingAttempt(false);
    }
  }

  Future<void> postQuizAttemptAnswer({
    required String quizAttemptId,
    required String questionId,
    required String jawabanSiswa,
  }) async {
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
      isLoadingAnswer(true);
      Map body = {
        'question_id': questionId,
        'jawaban_siswa': jawabanSiswa,
      };
      log(body.toString());
      final response = await http.post(
        Uri.parse(
            "${ApiConstants.baseUrlApi}/quiz-attempts/$quizAttemptId/answer"),
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        isCorrect.value = json['data']['correct'];
        isLastQuestion.value = json['data']['selesai'];
        quizId.value = json['data']['quiz_id'];
        quizAnswerM = QuizAnswerModel.fromJson(json);
      } else {
        log("Terjadi kesalahan post answer quiz: ${response.statusCode}");
      }
    } catch (e) {
      log("Error post Answer quiz simple: $e");
    } finally {
      isLoadingAnswer(false);
    }
  }
}
