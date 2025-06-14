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
      appBar: AppBar(
        title: const MyText(
          text: "Tugas",
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
                    text: "Pilih Mata Pelajaran",
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 20),
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
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.assignment,
                                  size: 64,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                const MyText(
                                  text: "Tidak Ada Mata Pelajaran",
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          );
                        }
                        return ListView.builder(
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
                        );
                      },
                    ),
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF57E389).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.assignment,
                  color: Color(0xFF57E389),
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: title,
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 4),
                    MyText(
                      text: "Guru: $guru",
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
