// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                id_matpel: Get.arguments,
                kelasC: kelasC,
                tahunAjaranC: tahunAjaranC,
                tugasDetailGuruC: tugasDetailGuruC),
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
                            // var tenggat = data.tenggat;
                            // int year = int.parse(tenggat.getYear());
                            // int month = int.parse(tenggat.getMonthNumber());
                            // int day = int.parse(tenggat.getTgl());

                            // await getCurrentTime();

                            // DateTime batasTanggal = DateTime(year, month, day);

                            // if (dateNow!.isAfter(batasTanggal)) {
                            //   snackbarfailed(
                            //       "Batas waktu sudah lewat, tidak bisa mengumpulkan tugas.");
                            // } else {
                            //   Get.toNamed(
                            //     AppRoutes.tugasCommitSiswa,
                            //     arguments: {
                            //       "id": data.id,
                            //       "tipe_tugas": "belum",
                            //       "submitTugas": null
                            //     },
                            //   )?.then((value) {
                            //     if (value == true) {
                            //       // Panggil ulang controller atau refresh data di halaman ini
                            //       tugasC.getTugas(
                            //           id: Get.arguments.toString(),
                            //           type: "belum");
                            //     }
                            //   });
                            // }
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
