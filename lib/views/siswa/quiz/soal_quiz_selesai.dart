// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/siswa/quiz/controllers/quiz_finish_controller.dart';

class SoalQuizSelesai extends StatelessWidget {
  SoalQuizSelesai({super.key});
  QuizFinishController quizFinishC = Get.find<QuizFinishController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Selesai"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.green.shade300,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Skor
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Obx(
                  () {
                    if (quizFinishC.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    var data = quizFinishC.quizAttemptM?.data;

                    if (data == null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'SKOR ANDA',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          // '9/10',
                          data.skor.toString(),
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // const SizedBox(height: 20),

              // // Rekomendasi Materi
              // const Text(
              //   'Rekomendasi Materi !',
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // const SizedBox(height: 20),

              // Container(
              //   padding:
              //       const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              //   margin: const EdgeInsets.symmetric(horizontal: 20),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(20),
              //     border: Border.all(color: Colors.blue, width: 2),
              //   ),
              //   child: const Center(
              //     child: Text(
              //       'Anatomi Tubuh',
              //       style: TextStyle(
              //         fontSize: 20,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
              // ),

              const SizedBox(height: 40),

              // Tombol Kembali
              ElevatedButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.siswaDashboard);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text(
                  'Kembali',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
