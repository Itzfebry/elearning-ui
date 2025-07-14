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

        // Cek pesan soal habis di data.original.message
        if (json['data'] != null &&
            json['data']['original'] != null &&
            json['data']['original']['message'] != null) {
          String msg =
              json['data']['original']['message'].toString().toLowerCase();
          if (msg.contains('tidak ada soal lagi di level ini') ||
              msg.contains('soal habis') ||
              msg.contains('questions exhausted') ||
              msg.contains('no more questions')) {
            log('Detected questions exhausted in data.original.message');
            await handleQuestionsExhausted(attemptId);
            return;
          }
        }

        // Cek apakah response mengandung pesan soal habis
        if (json.containsKey('message')) {
          String message = json['message'].toString().toLowerCase();
          if (message.contains("tidak ada soal lagi di level ini") ||
              message.contains("soal habis") ||
              message.contains("questions exhausted") ||
              message.contains("no more questions")) {
            log("200 response with questions exhausted message detected");
            await handleQuestionsExhausted(attemptId);
            return;
          }
        }

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
      } else if (response.statusCode == 204) {
        log("204 - No Content - Soal habis di level ini detected");
        // 204 No Content biasanya mengindikasikan tidak ada data/soal
        await handleQuestionsExhausted(attemptId);
      } else if (response.statusCode == 404) {
        log("404 - Soal habis di level ini detected");
        // Cek apakah response body mengandung pesan spesifik
        String responseBody = response.body.toLowerCase();
        if (responseBody.contains("tidak ada soal lagi di level ini") ||
            responseBody.contains("soal habis") ||
            responseBody.contains("questions exhausted")) {
          log("Confirmed: Questions exhausted at this level");
          // Soal habis di level ini, hentikan quiz otomatis
          await handleQuestionsExhausted(attemptId);
        } else {
          // 404 lainnya, tampilkan error umum
          log("404 error but not questions exhausted: ${response.body}");
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

  // Method untuk menangani ketika soal habis di level tertentu
  Future<void> handleQuestionsExhausted(String attemptId) async {
    try {
      log("Handling questions exhausted for attempt ID: $attemptId");

      // Hentikan timer quiz
      QuizAttemptController quizAttemptC = Get.find<QuizAttemptController>();
      quizAttemptC.stopQuizTimer();
      quizAttemptC.isQuizFinished.value = true;
      quizQuestionM = null;
      update();
      log("Quiz timer stopped, quizQuestionM set to null, UI updated");

      // Tampilkan pesan ke user
      Get.dialog(
        AlertDialog(
          title: const Text('Soal Habis'),
          content: const Text('Soal sudah habis di level ini, quiz selesai.'),
          actions: [
            TextButton(
              onPressed: () async {
                Get.back();
                // Auto finish quiz
                await autoFinishQuiz(attemptId);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      log("Error handling questions exhausted: $e");
      // Fallback: langsung redirect ke halaman selesai
      Get.offAllNamed('/quiz-selesai', arguments: {'quiz_id': ''});
    }
  }

  // Method untuk auto finish quiz ketika soal habis
  Future<void> autoFinishQuiz(String attemptId) async {
    try {
      QuizAttemptController quizAttemptC = Get.find<QuizAttemptController>();
      quizAttemptC.isQuizFinished.value = true;
      quizQuestionM = null;
      update();
      log("autoFinishQuiz: isQuizFinished set, quizQuestionM set to null, UI updated");

      // Kirim jawaban kosong untuk semua soal yang belum dijawab
      for (String qid in quizAttemptC.allQuestionIds) {
        if (!quizAttemptC.answeredQuestions.containsKey(qid)) {
          // Kirim jawaban kosong
          await quizAttemptC.postQuizAttemptAnswer(
            quizAttemptId: attemptId,
            questionId: qid,
            jawabanSiswa: "",
          );
        }
      }

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception("Token not found");
      }

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      log("Auto finishing quiz for attempt ID: $attemptId");
      log("[DEBUG] Auto finish URL: ${ApiConstants.quizAutoFinishEnpoint}/$attemptId");

      final response = await http.post(
        Uri.parse("${ApiConstants.quizAutoFinishEnpoint}/$attemptId"),
        headers: headers,
      );

      log("Auto finish response status: ${response.statusCode}");
      log("Auto finish response body: ${response.body}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        log("Auto finish success: $json");

        // Redirect ke halaman hasil quiz
        String quizId = json['quiz_id']?.toString() ?? '';
        Get.offAllNamed('/quiz-selesai', arguments: {'quiz_id': quizId});
      } else {
        log("Auto finish failed: ${response.statusCode} - ${response.body}");
        // Handle auto finish failure
        Get.dialog(
          AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Gagal menyelesaikan quiz otomatis. Silakan hubungi admin.'),
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
      log("Error auto finish quiz: $e");
      // Handle network error
      Get.dialog(
        AlertDialog(
          title: const Text('Error Koneksi'),
          content: const Text(
              'Gagal menyelesaikan quiz. Silakan cek internet Anda.'),
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
  }
}
