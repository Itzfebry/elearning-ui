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
          title: const Text(
            'Quiz',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.green.shade300,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            // Timer kecil di pojok kanan
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.9),
                    Colors.white.withOpacity(0.7)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() {
                    final minutes = quizAttemptC.waktuTersisa.value ~/ 60;
                    final seconds = quizAttemptC.waktuTersisa.value % 60;
                    final isWarning = quizAttemptC.waktuTersisa.value <= 300;
                    final isCritical = quizAttemptC.waktuTersisa.value <= 60;

                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isCritical ? Icons.warning : Icons.access_time,
                          color: isCritical
                              ? Colors.red.shade600
                              : isWarning
                                  ? Colors.orange.shade600
                                  : Colors.blue.shade600,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isCritical
                                ? Colors.red.shade600
                                : isWarning
                                    ? Colors.orange.shade600
                                    : Colors.blue.shade600,
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
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
              child: Text(
                'Soal tidak tersedia atau sudah habis. Silakan kembali ke dashboard.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            );
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: 400,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.green.shade400,
                        Colors.green.shade300,
                        Colors.green.shade200,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Kotak Soal
                      Container(
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        constraints: const BoxConstraints(
                          minHeight: 120,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.grey.shade50,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Text(
                                "Soal",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              data.pertanyaan,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      buildJawaban(
                          context, data.id.toString(), "a", data.opsiA),
                      buildJawaban(
                          context, data.id.toString(), "b", data.opsiB),
                      buildJawaban(
                          context, data.id.toString(), "c", data.opsiC),
                      buildJawaban(
                          context, data.id.toString(), "d", data.opsiD),

                      // Tambahan padding di bawah untuk menghindari overflow
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
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
    return Obx(() {
      bool isAnswered = quizAttemptC.isQuestionAnswered(questionId);
      String? selectedAnswer = quizAttemptC.getSelectedAnswer(questionId);
      bool isThisOptionSelected = selectedAnswer == opsi;

      // Tentukan warna berdasarkan status
      Color backgroundColor;
      Color textColor;
      List<Color> gradientColors;

      if (isAnswered) {
        if (isThisOptionSelected) {
          // Jawaban yang dipilih - hijau
          backgroundColor = Colors.green.shade100;
          textColor = Colors.green.shade800;
          gradientColors = [Colors.green.shade400, Colors.green.shade300];
        } else {
          // Jawaban lain yang tidak dipilih - abu-abu
          backgroundColor = Colors.grey.shade100;
          textColor = Colors.grey.shade600;
          gradientColors = [Colors.grey.shade400, Colors.grey.shade300];
        }
      } else {
        // Belum dijawab - putih
        backgroundColor = Colors.white;
        textColor = Colors.black87;
        gradientColors = [Colors.green.shade400, Colors.green.shade300];
      }

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: isAnswered
              ? null
              : () async {
                  // Simpan jawaban yang dipilih
                  quizAttemptC.saveAnswer(questionId, opsi);

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

                    // Log detailed information for debugging
                    log("Answer response received:");
                    log("- Quiz Answer Model: ${quizAttemptC.quizAnswerM}");
                    log("- Correct value: ${quizAttemptC.quizAnswerM?.data.correct}");
                    log("- Quiz ID: ${quizAttemptC.quizIdRx.value}");
                    log("- Is Last Question: ${quizAttemptC.isLastQuestion.value}");

                    // Ensure we have valid data before showing dialog
                    if (quizAttemptC.quizAnswerM != null) {
                      var correctValue = quizAttemptC.quizAnswerM!.data.correct;
                      log("About to show result dialog:");
                      log("- Correct value: $correctValue (type: ${correctValue.runtimeType})");
                      log("- Correct as string: '${correctValue.toString()}'");
                      log("- Is correct == 1: ${correctValue == 1}");
                      log("- Is correct == '1': ${correctValue.toString() == '1'}");

                      showResultDialog(
                        context,
                        correctValue.toString(),
                        "${opsi.toUpperCase()}. $label",
                        quizAttemptC.isLastQuestion.value,
                        quizAttemptC.quizIdRx.value.toString(),
                      );
                    } else {
                      // Handle case where answer model is null
                      log("Quiz answer model is null, showing error dialog");
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Error"),
                          content: const Text(
                              "Gagal memproses jawaban. Silakan coba lagi."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    }
                  } catch (e) {
                    log("Error posting answer: $e");
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Error"),
                        content: const Text(
                            "Terjadi kesalahan saat mengirim jawaban. Silakan coba lagi."),
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
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: textColor,
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: isAnswered ? 1 : 3,
            shadowColor: Colors.transparent, // Shadow sudah di Container
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container untuk option label (A, B, C, D)
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22.5),
                  boxShadow: [
                    BoxShadow(
                      color: gradientColors[0].withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    opsi.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              // Answer text aligned with the option label
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                      height: 1.3,
                    ),
                    overflow: TextOverflow.visible,
                    softWrap: true,
                  ),
                ),
              ),
              // Icon untuk menunjukkan status
              if (isAnswered && isThisOptionSelected)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green.shade600,
                    size: 24,
                  ),
                ),
            ],
          ),
        ),
      );
    });
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
    // Log the values for debugging
    log("showResultDialog called with:");
    log("- isCorrect: '$isCorrect'");
    log("- answer: '$answer'");
    log("- isLastQuestion: $isLastQuestion");
    log("- quizId: '$quizId'");

    // Determine if answer is correct
    bool isAnswerCorrect =
        isCorrect == "1" || isCorrect == "true" || isCorrect == "True";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isAnswerCorrect
                  ? [
                      Colors.green.shade400,
                      Colors.green.shade300,
                      Colors.green.shade200,
                    ]
                  : [
                      Colors.red.shade400,
                      Colors.red.shade300,
                      Colors.red.shade200,
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: (isAnswerCorrect ? Colors.green : Colors.red)
                    .withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon dan Status
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Icon(
                  isAnswerCorrect ? Icons.check_circle : Icons.cancel,
                  size: 50,
                  color: isAnswerCorrect
                      ? Colors.green.shade600
                      : Colors.red.shade600,
                ),
              ),
              const SizedBox(height: 20),

              // Text Status
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isAnswerCorrect ? 'Jawaban Benar!' : 'Jawaban Salah!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isAnswerCorrect
                        ? Colors.green.shade700
                        : Colors.red.shade700,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Jawaban yang dipilih
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: isAnswerCorrect
                        ? Colors.green.shade300
                        : Colors.red.shade300,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Jawaban Anda:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isAnswerCorrect
                            ? Colors.green.shade600
                            : Colors.red.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      answer,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Tombol
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    Get.back();
                    if (isLastQuestion) {
                      log("Quiz selesai, redirecting to finish page");
                      log("Quiz ID: $quizId");
                      log("Attempt ID: ${quizAttemptC.attemptId.value}");

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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: isAnswerCorrect
                        ? Colors.green.shade600
                        : Colors.red.shade600,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                  ),
                  child: Text(
                    isLastQuestion ? 'Lihat Hasil' : 'Lanjutkan',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
