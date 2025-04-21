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
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                          title: Text(
                            data.nama,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText(
                                  text: data.tanggal.simpleDateRevers(),
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                                MyText(
                                  text:
                                      "Tenggat : ${data.tenggat.simpleDateRevers()}",
                                  fontSize: 14,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                )
                              ],
                            ),
                          ),
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
                          }),
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
