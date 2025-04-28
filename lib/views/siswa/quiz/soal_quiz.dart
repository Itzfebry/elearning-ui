import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/siswa/quiz/controllers/quiz_attempt_controller.dart';
import 'package:ui/widgets/my_snackbar.dart';

class SoalQuiz extends StatefulWidget {
  const SoalQuiz({super.key});

  @override
  State<SoalQuiz> createState() => _SoalQuizState();
}

class _SoalQuizState extends State<SoalQuiz> {
  int currentQuestion = 0;
  QuizAttemptController quizAttemptC = Get.find<QuizAttemptController>();

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Apa ibu kota Indonesia?',
      'options': ['Jakarta', 'Surabaya', 'Bandung', 'Medan'],
      'answerIndex': 0,
    },
    {
      'question': 'Gunung tertinggi di Indonesia?',
      'options': ['Semeru', 'Bromo', 'Jaya Wijaya', 'Rinjani'],
      'answerIndex': 2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    var current = questions[currentQuestion];

    return WillPopScope(
      onWillPop: () async {
        return await _showExitConfirmationDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Soal Quiz"),
        ),
        body: Padding(
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
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      current['question'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Opsi Jawaban
                ...List.generate(current['options'].length, (index) {
                  return buildJawaban(
                    context,
                    '${String.fromCharCode(65 + index)}. ${current['options'][index]}',
                    index == current['answerIndex'],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildJawaban(BuildContext context, String label, bool isCorrect) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: InkWell(
        onTap: () {
          showResultDialog(context, isCorrect, label);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void showResultDialog(BuildContext context, bool isCorrect, String answer) {
    bool isLastQuestion = currentQuestion == questions.length - 1;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor:
            isCorrect ? Colors.green.shade100 : Colors.red.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        content: SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isCorrect ? 'Jawaban Benar ✅' : 'Jawaban Salah ❌',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                answer,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Get.back();

                if (isLastQuestion) {
                  snackbarSuccess("Quiz Selesai");
                  Get.offAllNamed(AppRoutes.quizSelesai);
                } else {
                  setState(() {
                    currentQuestion++;
                  });
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
