// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/siswa/quiz/controllers/quiz_controller.dart';
import 'package:ui/widgets/my_text.dart';

class MatpelQuizDetail extends StatelessWidget {
  MatpelQuizDetail({super.key});
  QuizController quizC = Get.find<QuizController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz ${Get.arguments['matpel']}"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Obx(() {
                  if (quizC.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (quizC.isEmptyData.value) {
                    return const Center(
                      child: MyText(
                          text: "Tidak Ada Quiz",
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    );
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFBBDBD0),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: ListView.builder(
                        itemCount: quizC.quizM?.data.length ?? 0,
                        itemBuilder: (context, index) {
                          var data = quizC.quizM?.data[index];
                          return SizedBox(
                            child: SizedBox(
                              child: TaskItem(
                                id: data!.id.toString(),
                                title: data.judul,
                                total: data.totalSoalTampil.toString(),
                                status: data.quizAttempt != null ? true : false,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final String id;
  final String title;
  final String total;
  final bool status;

  const TaskItem({
    super.key,
    required this.id,
    required this.title,
    required this.total,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (status) {
          Get.toNamed(AppRoutes.quizSelesai, arguments: {'quiz_id': id});
        } else {
          Get.offAllNamed(AppRoutes.soalQuiz, arguments: {
            "quiz_id": id,
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF67DEAC),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            Text(
              "Total soal : $total",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            Text(
              "Status : ${status ? "Sudah dikerjakan" : "Belum dikerjakan"}",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
