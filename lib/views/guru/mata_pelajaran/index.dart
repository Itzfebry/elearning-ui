// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/kelas_controller.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/mata_pelajaran_guru_controller.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/tahun_ajaran_controller.dart';
import 'package:ui/views/guru/mata_pelajaran/filter_matpel.dart';
import 'package:ui/widgets/my_date_format.dart';
import 'package:ui/widgets/my_text.dart';

class MataPelajaranGuru extends StatefulWidget {
  const MataPelajaranGuru({super.key});

  @override
  State<MataPelajaranGuru> createState() => _MataPelajaranGuruState();
}

class _MataPelajaranGuruState extends State<MataPelajaranGuru> {
  MataPelajaranGuruController matpelGuruC =
      Get.find<MataPelajaranGuruController>();

  KelasController kelasC = Get.find<KelasController>();
  TahunAjaranController tahunAjaranC = Get.find<TahunAjaranController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyText(
          text: "Mata Pelajaran",
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
          child: Column(
            children: [
              // Header with Filter
              Container(
                width: Get.width,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFF57E389),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: FilterMatpel(
                  kelasC: kelasC,
                  tahunAjaranC: tahunAjaranC,
                  matpelGuruC: matpelGuruC,
                ),
              ),

              // Data List
              Expanded(
                child: Obx(() {
                  if (matpelGuruC.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (!matpelGuruC.isFetchData.value) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.filter_list,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          const MyText(
                            text: "Silahkan Filter untuk\nMelihat Data",
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  } else if (matpelGuruC.isEmptyData.value) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.school,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          MyText(
                            text:
                                "Data Mata Pelajaran kelas ${kelasC.selectedKelas.value}\nPada tahun ajaran ${tahunAjaranC.selectedTahun.value}\nMasih Kosong",
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: matpelGuruC.mataPelajaranM?.data.length ?? 0,
                    itemBuilder: (context, index) {
                      final data = matpelGuruC.mataPelajaranM!.data[index];
                      return GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.materiSiswa,
                            arguments: data.id),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF57E389)
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(
                                        Icons.book,
                                        color: Color(0xFF57E389),
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MyText(
                                            text: data.nama,
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          const SizedBox(height: 4),
                                          MyText(
                                            text: "Guru: ${data.guru.nama}",
                                            fontSize: 14,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildStatItem(
                                      icon: Icons.menu_book,
                                      value: "${data.jumlahBuku}",
                                      label: "Materi",
                                      color: Colors.red,
                                    ),
                                    _buildStatItem(
                                      icon: Icons.video_library,
                                      value: "${data.jumlahVideo}",
                                      label: "Video",
                                      color: Colors.blue,
                                    ),
                                    _buildStatItem(
                                      icon: Icons.update,
                                      value: (data.materi.isNotEmpty
                                              ? data.materi.last.tanggal
                                              : data.createdAt)
                                          .getSimpleDayAndDate(),
                                      label: "Diperbarui",
                                      color: Colors.green,
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
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          MyText(
            text: value,
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w600,
          ),
          MyText(
            text: label,
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
