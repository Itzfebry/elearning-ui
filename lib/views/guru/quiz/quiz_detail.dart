// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/views/guru/quiz/controllers/quiz_detail_guru_controller.dart';
import 'package:ui/widgets/my_text.dart';

class QuizDetailGuru extends StatelessWidget {
  QuizDetailGuru({super.key});
  QuizDetailGuruController quizDetailGuruC =
      Get.find<QuizDetailGuruController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.amber,
        title: const Text("Quiz"),
      ),
      body: Column(
        children: [
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.green.shade200,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                child: MyText(
                  text: Get.arguments['judul'],
                  textAlign: TextAlign.center,
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () {
              if (quizDetailGuruC.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (quizDetailGuruC.isEmptyData.value) {
                return const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                    child: MyText(
                      text: "Quiz Masih Kosong",
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: quizDetailGuruC.data.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 7),
                itemBuilder: (context, index) {
                  var data = quizDetailGuruC.data[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 30,
                              child: CircleAvatar(
                                child: Text("${index + 1}",
                                    style: const TextStyle(fontSize: 14)),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  text: data['nama'],
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                                MyText(
                                  text:
                                      "Skor : ${data['skor']} | Nilai : ${data['persentase']} | KKM : ${data['kkm']}",
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
