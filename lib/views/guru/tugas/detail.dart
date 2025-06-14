// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/kelas_controller.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/tahun_ajaran_controller.dart';
import 'package:ui/views/guru/tugas/controllers/tugas_detail_guru_controller.dart';
import 'package:ui/views/guru/tugas/filter_tugas.dart';
import 'package:ui/widgets/my_date_format.dart';
import 'package:ui/widgets/my_text.dart';

class DetailTugasGuru extends StatelessWidget {
  DetailTugasGuru({super.key});
  KelasController kelasC = Get.find<KelasController>();
  TahunAjaranController tahunAjaranC = Get.find<TahunAjaranController>();
  TugasDetailGuruController tugasDetailGuruC =
      Get.find<TugasDetailGuruController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Tugas"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            FilterTugas(
                idMatpel: Get.arguments['id'].toString(),
                kelasC: kelasC,
                tahunAjaranC: tahunAjaranC,
                tugasSubmitDetailGuruC: tugasDetailGuruC),
            Obx(
              () {
                if (tugasDetailGuruC.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (!tugasDetailGuruC.isFetchData.value) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 100),
                    child: Center(
                        child: Text(
                      "Silahkan Filter untuk\nMelihat Data.",
                      textAlign: TextAlign.center,
                    )),
                  );
                } else if (tugasDetailGuruC.isEmptyData.value) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: Center(
                      child: Text(
                        "Data Tugas untuk kelas ${kelasC.selectedKelas.value}\nPada tahun ajaran ${tahunAjaranC.selectedTahun.value}\nDengan Tipe Tugas ${tugasDetailGuruC.selectedTypeTugas.value}\nMasih Kosong",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: tugasDetailGuruC.tugasM?.data.length ?? 0,
                  itemBuilder: (context, index) {
                    var data = tugasDetailGuruC.tugasM!.data[index];
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
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () async {
                            Get.toNamed(
                              AppRoutes.detailSubmitTugasDetailGuru,
                              arguments: {
                                "id": data.id,
                                "kelas": kelasC.selectedKelas.value,
                                "tahun_ajaran":
                                    tahunAjaranC.selectedTahun.value,
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF57E389)
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        Icons.assignment,
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
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          const SizedBox(height: 4),
                                          MyText(
                                            text:
                                                "Dibuat: ${data.tanggal.simpleDateRevers()}",
                                            fontSize: 12,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.timer_outlined,
                                        color: Colors.red,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      MyText(
                                        text:
                                            "Tenggat: ${data.tenggat.simpleDateRevers()}",
                                        fontSize: 12,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
