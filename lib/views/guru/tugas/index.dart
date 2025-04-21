// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/siswa/matapelajaran/controllers/mata_pelajaran_simple_controller.dart';
import 'package:ui/widgets/my_text.dart';

class TugasGuruPage extends StatelessWidget {
  TugasGuruPage({super.key});
  MataPelajaranSimpleController matapelajaranSimpleC =
      Get.find<MataPelajaranSimpleController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tugas")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Obx(
                  () {
                    if (matapelajaranSimpleC.isLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (matapelajaranSimpleC
                            .mataPelajaranSimpleM?.data.isEmpty ??
                        true) {
                      return const Center(
                        child: MyText(
                            text: "Tidak Ada Mata Pelajaran",
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
                          itemCount: matapelajaranSimpleC
                                  .mataPelajaranSimpleM?.data.length ??
                              0,
                          itemBuilder: (context, index) {
                            var data = matapelajaranSimpleC
                                .mataPelajaranSimpleM?.data[index];
                            return TaskItem(
                              id: data!.id.toString(),
                              title: data.nama,
                              guru: data.guru.nama,
                              mataPelajaranId: data.id.toString(),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
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
  final String guru;
  final String mataPelajaranId;

  const TaskItem({
    super.key,
    required this.id,
    required this.title,
    required this.guru,
    required this.mataPelajaranId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.tugasDetailGuru, arguments: {
          'id': id,
        });
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
              "Guru : $guru",
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
