import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/siswa/quiz/controllers/quiz_attempt_controller.dart';
import 'package:ui/views/siswa/quiz/controllers/quiz_question_controller.dart';
import 'package:ui/widgets/my_snackbar.dart';

class SoalQuiz extends StatefulWidget {
  const SoalQuiz({super.key});

  @override
  State<SoalQuiz> createState() => _SoalQuizState();
}

class _SoalQuizState extends State<SoalQuiz> {
  int currentQuestion = 0;
  QuizAttemptController quizAttemptC = Get.find<QuizAttemptController>();
  QuizQuestionController quizQuestionC = Get.find<QuizQuestionController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _showExitConfirmationDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Soal Quiz"),
        ),
        body: Obx(() {
          if (quizQuestionC.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var data = quizQuestionC.quizQuestionM?.data;

          if (data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green.shade300,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Kotak Soal
                  Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Soal :",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            data.pertanyaan,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  buildJawaban(context, data.id.toString(), "a", data.opsiA),
                  buildJawaban(context, data.id.toString(), "b", data.opsiB),
                  buildJawaban(context, data.id.toString(), "c", data.opsiC),
                  buildJawaban(context, data.id.toString(), "d", data.opsiD),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget buildJawaban(
    BuildContext context,
    String questionId,
    String opsi,
    String label,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: InkWell(
        onTap: () async {
          log({
            "attempt_id": quizAttemptC.attemptId.value,
            "question_id": questionId,
            "opsi": opsi,
          }.toString());

          try {
            await quizAttemptC.postQuizAttemptAnswer(
              quizAttemptId: quizAttemptC.attemptId.value.toString(),
              questionId: questionId,
              jawabanSiswa: opsi,
            );
            log("APAPAH BENAR: ${quizAttemptC.quizAnswerM!.data.correct}");
            log("QUIZ ID: ${quizAttemptC.quizIdRx.value}");
            showResultDialog(
              context,
              quizAttemptC.quizAnswerM?.data.correct.toString() ?? "0",
              "${opsi.toUpperCase()}. $label",
              quizAttemptC.isLastQuestion.value,
              quizAttemptC.quizIdRx.value.toString(),
            );
          } catch (e) {
            Get.back();

            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("Gagal"),
                content: const Text("Jawaban gagal dikirim. Coba lagi."),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("OK"),
                  ),
                ],
              ),
            );
          }
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            "${opsi.toUpperCase()}. $label",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        backgroundColor: Colors.white,
        content: SizedBox(
          width: 50,
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  void showResultDialog(
    BuildContext context,
    String isCorrect,
    String answer,
    bool isLastQuestion,
    String quizId,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor:
            isCorrect == "1" ? Colors.green.shade100 : Colors.red.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        content: SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isCorrect == "1" ? 'Jawaban Benar ✅' : 'Jawaban Salah ❌',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                answer,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                Get.back();
                if (isLastQuestion) {
                  snackbarSuccess("Quiz Selesai");
                  Get.offAllNamed(
                    AppRoutes.quizSelesai,
                    arguments: {'quiz_id': quizId},
                  );
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  final attemptId = prefs.getString('attempt_id');
                  await quizQuestionC.getQuizQuestion(attemptId);
                }
              },
              child: Text(isLastQuestion ? 'Selesai' : 'Next'),
            ),
          ),
        ],
      ),
    );
  }

  // Menampilkan konfirmasi saat pengguna mencoba keluar sebelum quiz selesai
  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible:
              false, // Tidak bisa ditutup dengan mengetuk di luar dialog
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Konfirmasi'),
              content: const Text(
                  'Anda belum menyelesaikan quiz. Apakah Anda yakin ingin keluar?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Batal'),
                  onPressed: () {
                    Navigator.of(context).pop(false); // Jangan keluar
                  },
                ),
                TextButton(
                  child: const Text('Keluar'),
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.siswaDashboard);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
