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
  var isLastQuestion = false.obs;
  var quizIdRx = "".obs;
  var attemptId = "".obs;
  var token = "".obs;
  var nisn = "".obs;
  QuizAnswerModel? quizAnswerM;
  QuizQuestionController questionC = Get.find<QuizQuestionController>();

  @override
  void onInit() async {
    super.onInit();
    final prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token') ?? "";
    nisn.value = prefs.getString('nisn') ?? "";
    var quizId = Get.arguments['quiz_id'];
    await postQuizAttemptStart(quizId);
    attemptId.value = prefs.getString('attempt_id') ?? "";
  }

  Future<void> postQuizAttemptStart(var quizId) async {
    final prefs = await SharedPreferences.getInstance();
    if (token.value == "") {
      throw Exception("Token not found");
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token.value}',
    };

    try {
      isLoadingAttempt(true);
      Map body = {
        'quiz_id': quizId,
        'nisn': nisn.value,
      };
      final response = await http.post(
        Uri.parse(ApiConstants.quizAttemptStartEnpoint),
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json.containsKey('attempt_id')) {
          await prefs.setString('attempt_id', json['attempt_id'].toString());
          questionC.getQuizQuestion(json['attempt_id']);
        } else {
          log("JSON tidak memiliki 'attempt_id'");
        }

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
    if (token.value == "") {
      throw Exception("Token not found");
    }
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token.value}',
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
        isLastQuestion.value = json['data']['selesai'];
        quizIdRx.value = json['data']['quiz_id'].toString();
        quizAnswerM = QuizAnswerModel.fromJson(json);
        log("DATA API = ${json['data']}");
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
