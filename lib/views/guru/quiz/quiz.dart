// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/guru/quiz/controllers/quiz_guru_controller.dart';
import 'package:ui/widgets/my_text.dart';

class QuizGuru extends StatelessWidget {
  QuizGuru({super.key});
  QuizGuruController quizC = Get.find<QuizGuruController>();

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
                    return ListView.builder(
                      itemCount: quizC.quizGuruM?.data.length ?? 0,
                      itemBuilder: (context, index) {
                        var data = quizC.quizGuruM?.data[index];
                        return InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.quizDetailGuru, arguments: {
                              'quiz_id': data.id.toString(),
                              'kelas': Get.arguments['kelas'],
                              'tahun_ajaran': Get.arguments['tahun_ajaran'],
                              'judul': data.judul,
                            });
                          },
                          child: Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black38,
                                    offset: Offset(0, 1),
                                    blurRadius: 2,
                                  ),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: MyText(
                                text: data!.judul,
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
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
    );
  }
}
