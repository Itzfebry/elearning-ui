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
import 'dart:async';

class QuizAttemptController extends GetxController {
  var isLoadingAttempt = false.obs;
  var isLoadingAnswer = false.obs;
  var isLastQuestion = false.obs;
  var quizIdRx = "".obs;
  var attemptId = "".obs;
  var token = "".obs;
  var nisn = "".obs;
  var waktuQuiz = 0.obs; // Menambahkan waktu quiz dalam menit
  var waktuTersisa = 0.obs; // Menambahkan waktu tersisa dalam detik
  var waktuMulai = DateTime.now().obs; // Menambahkan waktu mulai
  Timer? timer; // Timer untuk countdown
  QuizAnswerModel? quizAnswerM;
  QuizQuestionController questionC = Get.find<QuizQuestionController>();
  var remainingTime = Duration.zero.obs;
  var isTimerRunning = false.obs;

  // Menambahkan tracking jawaban yang telah dijawab
  var answeredQuestions =
      <String, String>{}.obs; // questionId -> selectedAnswer
  var currentQuestionId = "".obs;

  @override
  void onInit() async {
    super.onInit();
    final prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token') ?? "";
    nisn.value = prefs.getString('nisn') ?? "";
    var quizId = Get.arguments['quiz_id'];

    // Test model parsing
    testModelParsing();

    // Reset all data for fresh start (especially for retake)
    await resetQuizData();

    await postQuizAttemptStart(quizId);
    attemptId.value = prefs.getString('attempt_id') ?? "";
  }

  @override
  void onClose() {
    timer?.cancel(); // Cancel timer when controller is disposed
    super.onClose();
  }

  // Method untuk memulai timer
  void startTimer() {
    timer?.cancel(); // Cancel existing timer
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (waktuTersisa.value > 0) {
        waktuTersisa.value--;
      } else {
        timer.cancel();
        // Waktu habis, auto finish quiz
        autoFinishQuiz();
      }
    });
  }

  // Method untuk auto finish quiz ketika waktu habis
  Future<void> autoFinishQuiz() async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token.value}',
      };

      log("Auto finishing quiz for attempt ID: ${attemptId.value}");

      final response = await http.post(
        Uri.parse("${ApiConstants.quizAutoFinishEnpoint}/${attemptId.value}"),
        headers: headers,
      );

      log("Auto finish response status: ${response.statusCode}");
      log("Auto finish response body: ${response.body}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        log("Auto finish success: $json");

        // Tampilkan alert waktu habis
        Get.dialog(
          AlertDialog(
            title: const Text('Waktu Habis'),
            content: const Text(
                'Waktu pengerjaan quiz telah habis. Quiz akan diselesaikan otomatis.'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.offAllNamed('/quiz-selesai',
                      arguments: {'quiz_id': quizIdRx.value});
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
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

      log("Starting quiz with body: $body");
      log("Requesting URL: ${ApiConstants.quizAttemptStartEnpoint}");

      final response = await http.post(
        Uri.parse(ApiConstants.quizAttemptStartEnpoint),
        headers: headers,
        body: jsonEncode(body),
      );

      log("Start quiz response status: ${response.statusCode}");
      log("Start quiz response body: ${response.body}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json.containsKey('attempt_id')) {
          // Clear all previous attempt data
          await prefs.remove('attempt_id');
          await prefs.remove('quiz_answers');
          await prefs.remove('current_question_index');
          await prefs.remove('quiz_start_time');
          await prefs.remove('quiz_end_time');
          await prefs.remove('remaining_time');

          // Save new attempt ID
          await prefs.setString('attempt_id', json['attempt_id'].toString());
          log("New attempt ID saved: ${json['attempt_id']}");

          // Reset controller state
          attemptId.value = json['attempt_id'].toString();
          waktuTersisa.value = 0;
          waktuQuiz.value = 0;
          waktuMulai.value = DateTime.now();

          // Get quiz questions for new attempt
          questionC.getQuizQuestion(json['attempt_id']);
        } else {
          log("JSON tidak memiliki 'attempt_id'");
          Get.dialog(
            AlertDialog(
              title: const Text('Error'),
              content: const Text('Gagal memulai quiz. Silakan coba lagi.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                    Get.offAllNamed('/siswa-dashboard');
                  },
                  child: const Text('Kembali'),
                ),
              ],
            ),
          );
          return;
        }

        // Set waktu quiz dan mulai timer
        if (json.containsKey('waktu_quiz') && json['waktu_quiz'] != null) {
          waktuQuiz.value = json['waktu_quiz'];
          waktuTersisa.value = waktuQuiz.value * 60; // Konversi ke detik
          startTimer();
          log("Timer started with ${waktuQuiz.value} minutes");
        } else {
          log("No time limit for this quiz");
        }

        // Set waktu mulai
        if (json.containsKey('waktu_mulai')) {
          waktuMulai.value = DateTime.parse(json['waktu_mulai']);
          log("Start time set: ${waktuMulai.value}");
        }

        snackbarAlert(json['message'] ?? "Quiz",
            "Tidak boleh keluar dari quiz ini!.", Colors.green);

        log("New attempt started with ID: ${json['attempt_id'].toString()}");
      } else if (response.statusCode == 500) {
        log("Backend error 500 on quiz start: ${response.body}");
        Get.dialog(
          AlertDialog(
            title: const Text('Error Server'),
            content: const Text(
                'Terjadi kesalahan pada server saat memulai quiz. Silakan coba lagi.\n\nError: 500 Internal Server Error'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.offAllNamed('/siswa-dashboard');
                },
                child: const Text('Kembali'),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  // Retry starting quiz
                  postQuizAttemptStart(quizId);
                },
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        );
      } else if (response.statusCode == 404) {
        log("Quiz not found: ${response.body}");
        Get.dialog(
          AlertDialog(
            title: const Text('Quiz Tidak Ditemukan'),
            content: const Text(
                'Quiz yang dipilih tidak ditemukan atau tidak tersedia.'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.offAllNamed('/siswa-dashboard');
                },
                child: const Text('Kembali'),
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
            content: Text('Gagal memulai quiz. Status: ${response.statusCode}'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.offAllNamed('/siswa-dashboard');
                },
                child: const Text('Kembali'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      log("Error get matpel simple: $e");
      Get.dialog(
        AlertDialog(
          title: const Text('Error Koneksi'),
          content: const Text(
              'Terjadi kesalahan koneksi saat memulai quiz. Silakan cek internet Anda.'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                Get.offAllNamed('/siswa-dashboard');
              },
              child: const Text('Kembali'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                // Retry starting quiz
                postQuizAttemptStart(quizId);
              },
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      );
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

      final url =
          "${ApiConstants.baseUrlApi}/quiz-attempts/$quizAttemptId/answer";
      log("Posting answer to URL: $url");
      log("Request body: $body");

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      log("Answer response status: ${response.statusCode}");
      log("Answer response body: ${response.body}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        log("Parsed answer JSON: $json");

        // Log the raw data structure
        log("Raw JSON structure:");
        log("- status: ${json['status']}");
        log("- message: ${json['message']}");
        log("- data: ${json['data']}");

        if (json['data'] != null) {
          var data = json['data'];
          log("Data fields:");
          log("- quiz_id: ${data['quiz_id']} (type: ${data['quiz_id'].runtimeType})");
          log("- correct: ${data['correct']} (type: ${data['correct'].runtimeType})");
          log("- fase: ${data['fase']} (type: ${data['fase'].runtimeType})");
          log("- new_level: ${data['new_level']} (type: ${data['new_level'].runtimeType})");
          log("- skor_sementara: ${data['skor_sementara']} (type: ${data['skor_sementara'].runtimeType})");
          log("- selesai: ${data['selesai']} (type: ${data['selesai'].runtimeType})");
          log("- waktu_tersisa: ${data['waktu_tersisa']} (type: ${data['waktu_tersisa']?.runtimeType})");
        }

        try {
          isLastQuestion.value = json['data']['selesai'] ?? false;
          quizIdRx.value = json['data']['quiz_id'].toString();
          quizAnswerM = QuizAnswerModel.fromJson(json);

          // Update waktu tersisa dari response
          if (json['data']['waktu_tersisa'] != null) {
            waktuTersisa.value = json['data']['waktu_tersisa'];
          }

          // Log the parsed data
          if (quizAnswerM?.data != null) {
            var data = quizAnswerM!.data;
            log("Parsed answer data:");
            log("- Quiz ID: ${data.quizId}");
            log("- Correct: ${data.correct}");
            log("- Fase: ${data.fase}");
            log("- New Level: ${data.newLevel}");
            log("- Skor Sementara: ${data.skorSementara}");
            log("- Selesai: ${data.selesai}");
            log("- Waktu Tersisa: ${data.waktuTersisa}");
          }

          // Also log raw data for comparison
          log("Raw data comparison:");
          var rawData = json['data'];
          log("- Raw correct: ${rawData['correct']}");
          log("- Raw skor_sementara: ${rawData['skor_sementara']}");
          log("- Raw quiz_id: ${rawData['quiz_id']}");

          log("DATA API = ${json['data']}");
        } catch (parseError) {
          log("Error parsing answer response: $parseError");
          log("Parse error stack trace: ${StackTrace.current}");
          // Handle parsing error gracefully
          quizAnswerM = null;
        }
      } else {
        log("Terjadi kesalahan post answer quiz: ${response.statusCode}");
        log("Error response: ${response.body}");

        // Show error dialog for non-200 responses
        Get.dialog(
          AlertDialog(
            title: const Text('Error'),
            content: Text(
                'Gagal mengirim jawaban. Status: ${response.statusCode}\n\nResponse: ${response.body}'),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      log("Error post Answer quiz simple: $e");
    } finally {
      isLoadingAnswer(false);
    }
  }

  // Method untuk reset semua data quiz (untuk mengerjakan ulang)
  Future<void> resetQuizData() async {
    final prefs = await SharedPreferences.getInstance();

    // Clear all attempt-related data
    await prefs.remove('attempt_id');
    await prefs.remove('quiz_answers');
    await prefs.remove('current_question_index');
    await prefs.remove('quiz_start_time');
    await prefs.remove('quiz_end_time');
    await prefs.remove('remaining_time');

    // Reset controller state
    attemptId.value = "";
    waktuTersisa.value = 0;
    waktuQuiz.value = 0;
    waktuMulai.value = DateTime.now();

    // Cancel any running timer
    timer?.cancel();
    isTimerRunning.value = false;

    log("All quiz data has been reset for retake");
  }

  // Method untuk test parsing model
  void testModelParsing() {
    // Test data yang seharusnya berhasil
    Map<String, dynamic> testData = {
      "status": true,
      "message": "Success",
      "data": {
        "quiz_id": 1,
        "correct": 1,
        "fase": 1,
        "new_level": 1,
        "skor_sementara": 10,
        "selesai": false,
        "waktu_tersisa": 300
      }
    };

    try {
      var testModel = QuizAnswerModel.fromJson(testData);
      log("Test parsing successful:");
      log("- Correct: ${testModel.data.correct}");
      log("- Skor Sementara: ${testModel.data.skorSementara}");
    } catch (e) {
      log("Test parsing failed: $e");
    }
  }

  // Method untuk menyimpan jawaban yang dipilih
  void saveAnswer(String questionId, String selectedAnswer) {
    answeredQuestions[questionId] = selectedAnswer;
    currentQuestionId.value = questionId;
    log("Saved answer for question $questionId: $selectedAnswer");
  }

  // Method untuk mendapatkan jawaban yang dipilih
  String? getSelectedAnswer(String questionId) {
    return answeredQuestions[questionId];
  }

  // Method untuk mengecek apakah soal sudah dijawab
  bool isQuestionAnswered(String questionId) {
    return answeredQuestions.containsKey(questionId);
  }
}
