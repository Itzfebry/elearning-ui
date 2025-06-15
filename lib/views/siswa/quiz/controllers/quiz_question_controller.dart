import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:ui/models/quiz_question_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ui/views/siswa/quiz/controllers/quiz_attempt_controller.dart';

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
      log("Requesting quiz question URL: $url");
      log("Attempt ID: $attemptId");

      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      log("Response status: ${response.statusCode}");
      log("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        log("Parsed JSON: $json");

        // Cek apakah waktu sudah habis
        if (json.containsKey('waktu_habis') && json['waktu_habis'] == true) {
          log("Waktu habis detected");
          // Waktu habis, redirect ke halaman selesai
          Get.offAllNamed('/quiz-selesai',
              arguments: {'quiz_id': json['quiz_id'] ?? ''});
          return;
        }

        // Cek apakah quiz sudah selesai
        if (json.containsKey('selesai') && json['selesai'] == true) {
          log("Quiz selesai detected");
          // Quiz selesai, redirect ke halaman selesai
          Get.offAllNamed('/quiz-selesai',
              arguments: {'quiz_id': json['quiz_id'] ?? ''});
          return;
        }

        try {
          quizQuestionM = QuizQuestionModel.fromJson(json);
          log("Quiz question model created successfully");

          // Reset tracking jawaban untuk soal baru
          QuizAttemptController quizAttemptC =
              Get.find<QuizAttemptController>();
          quizAttemptC.answeredQuestions.clear();
          quizAttemptC.currentQuestionId.value = "";
          log("Reset answer tracking for new question");
        } catch (parseError) {
          log("Error parsing quiz question: $parseError");
          // Handle parsing error gracefully
          quizQuestionM = null;
          Get.dialog(
            AlertDialog(
              title: const Text('Error'),
              content: const Text('Gagal memuat soal quiz. Silakan coba lagi.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                    Get.offAllNamed('/siswa-dashboard');
                  },
                  child: const Text('Kembali ke Dashboard'),
                ),
              ],
            ),
          );
        }
      } else if (response.statusCode == 500) {
        log("Backend error 500: ${response.body}");
        // Handle 500 error - mungkin quiz tidak ada atau error di backend
        Get.dialog(
          AlertDialog(
            title: const Text('Error Server'),
            content: const Text(
                'Terjadi kesalahan pada server saat memuat soal. Silakan coba lagi atau hubungi admin.\n\nError: 500 Internal Server Error'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.offAllNamed('/siswa-dashboard');
                },
                child: const Text('Kembali ke Dashboard'),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  // Retry loading question
                  getQuizQuestion(attemptId);
                },
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        );
      } else {
        log("Terjadi kesalahan get data: ${response.statusCode}");
        log("Error response: ${response.body}");
        Get.dialog(
          AlertDialog(
            title: const Text('Error'),
            content:
                Text('Gagal memuat soal quiz. Status: ${response.statusCode}'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.offAllNamed('/siswa-dashboard');
                },
                child: const Text('Kembali ke Dashboard'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      log("Error get quiz question: $e");
      // Handle network or other errors
      Get.dialog(
        AlertDialog(
          title: const Text('Error Koneksi'),
          content: const Text(
              'Terjadi kesalahan koneksi saat memuat soal. Silakan cek internet Anda.'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                Get.offAllNamed('/siswa-dashboard');
              },
              child: const Text('Kembali ke Dashboard'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                // Retry loading question
                getQuizQuestion(attemptId);
              },
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      );
    } finally {
      isLoading(false);
    }
  }
}
