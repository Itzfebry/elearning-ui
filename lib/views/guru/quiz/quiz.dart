// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/guru/quiz/controllers/quiz_guru_controller.dart';
import 'package:ui/widgets/my_text.dart';
import 'package:ui/widgets/my_date_format.dart';

class QuizGuru extends StatelessWidget {
  QuizGuru({super.key});
  QuizGuruController quizC = Get.find<QuizGuruController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(
          text: "Quiz ${Get.arguments['matpel']}",
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: const Color(0xFF57E389),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF57E389),
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MyText(
                    text: "Daftar Quiz",
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Obx(() {
                      if (quizC.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (quizC.isEmptyData.value) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.quiz_outlined,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              const MyText(
                                text: "Belum ada quiz yang dibuat",
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: quizC.quizGuruM?.data.length ?? 0,
                          itemBuilder: (context, index) {
                            var data = quizC.quizGuruM?.data[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(AppRoutes.quizDetailGuru,
                                      arguments: {
                                        'quiz_id': data!.id.toString(),
                                        'kelas': Get.arguments['kelas'],
                                        'tahun_ajaran':
                                            Get.arguments['tahun_ajaran'],
                                        'judul': data.judul,
                                      });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.orange.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: const Icon(
                                          Icons.quiz,
                                          color: Colors.orange,
                                          size: 24,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MyText(
                                              text: data!.judul,
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            const SizedBox(height: 4),
                                            MyText(
                                              text:
                                                  "Dibuat pada: ${data.createdAt.simpleDateRevers()}",
                                              fontSize: 12,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
