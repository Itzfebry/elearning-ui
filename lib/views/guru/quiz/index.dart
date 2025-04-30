// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/kelas_controller.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/mata_pelajaran_guru_controller.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/tahun_ajaran_controller.dart';
import 'package:ui/views/guru/mata_pelajaran/filter_matpel.dart';
import 'package:ui/widgets/my_date_format.dart';

class MataPelajaranQuizGuru extends StatefulWidget {
  const MataPelajaranQuizGuru({super.key});

  @override
  State<MataPelajaranQuizGuru> createState() => _MataPelajaranQuizGuruState();
}

class _MataPelajaranQuizGuruState extends State<MataPelajaranQuizGuru> {
  MataPelajaranGuruController matpelGuruC =
      Get.find<MataPelajaranGuruController>();

  KelasController kelasC = Get.find<KelasController>();
  TahunAjaranController tahunAjaranC = Get.find<TahunAjaranController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mata Pelajaran Quiz")),
      body: Column(
        children: [
          // Filter Dropdown
          const SizedBox(height: 10),
          FilterMatpel(
              kelasC: kelasC,
              tahunAjaranC: tahunAjaranC,
              matpelGuruC: matpelGuruC),

          // Data Card
          Obx(() {
            if (matpelGuruC.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (!matpelGuruC.isFetchData.value) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 100),
                child: Center(
                    child: Text(
                  "Silahkan Filter untuk\nMelihat Data.",
                  textAlign: TextAlign.center,
                )),
              );
            } else if (matpelGuruC.isEmptyData.value) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 100),
                child: Center(
                  child: Text(
                    "Data Mata Pelajaran kelas ${kelasC.selectedKelas.value}\nPada tahun ajaran ${tahunAjaranC.selectedTahun.value}\nMasih Kosong",
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            return Expanded(
              child: ListView.builder(
                itemCount: matpelGuruC.mataPelajaranM?.data.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final data = matpelGuruC.mataPelajaranM!.data[index];
                  return GestureDetector(
                    onTap: () {
                      log(tahunAjaranC.selectedTahun.value.toString());
                      Get.toNamed(
                        AppRoutes.quizGuru,
                        arguments: {
                          'id': data.id,
                          'matpel': data.nama,
                          'kelas': kelasC.selectedKelas.value,
                          'tahun_ajaran': tahunAjaranC.selectedTahun.value
                        },
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.nama,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text("Guru: ${data.guru.nama}"),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
