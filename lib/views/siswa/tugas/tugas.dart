// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/views/siswa/matapelajaran/controllers/mata_pelajaran_simple_controller.dart';
import 'package:ui/views/siswa/tugas/tugas_detail.dart'; // Import halaman detail tugas

class Tugas extends StatelessWidget {
  Tugas({super.key});
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
                              title: data!.nama,
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
  final String title;
  final String mataPelajaranId; // ID mata pelajaran

  const TaskItem(
      {super.key, required this.title, required this.mataPelajaranId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail tugas
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => TugasDetail(mataPelajaranId: mataPelajaranId),
        //   ),
        // );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF67DEAC),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}
