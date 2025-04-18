import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntp/ntp.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/siswa/tugas/controllers/tugas_controller.dart';
import 'package:ui/widgets/my_date_format.dart';
import 'package:ui/widgets/my_snackbar.dart';
import 'package:ui/widgets/my_text.dart';

class TugasDetail extends StatefulWidget {
  const TugasDetail({super.key});

  @override
  State<TugasDetail> createState() => _TugasDetailState();
}

class _TugasDetailState extends State<TugasDetail> {
  TugasController tugasC = Get.find<TugasController>();
  var isActive = "belum";
  DateTime? dateNow;

  @override
  void initState() {
    super.initState();
    tugasC.getTugas(id: Get.arguments);
  }

  Future<void> getCurrentTime() async {
    DateTime now = await NTP.now();
    dateNow = DateTime(now.year, now.month, now.day);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Tugas")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: buttonTab(),
          ),
          if (isActive == "belum") tugasBelum(),
          if (isActive == "selesai") tugasSelesai(),
        ],
      ),
    );
  }

  Row buttonTab() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isActive = "belum";
            });
            tugasC.getTugas(id: Get.arguments);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            decoration: BoxDecoration(
              color: isActive == "belum"
                  ? const Color(0xFF75FF33)
                  : const Color(0xFFD2E5C9),
              borderRadius: BorderRadius.circular(32),
            ),
            child: const Text(
              "Belum",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isActive = "selesai";
            });
            tugasC.getTugas(id: Get.arguments);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            decoration: BoxDecoration(
              color: isActive == "selesai"
                  ? const Color(0xFF75FF33)
                  : const Color(0xFFD2E5C9),
              borderRadius: BorderRadius.circular(32),
            ),
            child: const Text(
              "Selesai",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Obx tugasBelum() {
    return Obx(() {
      if (tugasC.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (tugasC.tugasM?.data.isEmpty ?? true) {
        return emptyData();
      } else {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          itemCount: tugasC.tugasM?.data.length ?? 0,
          itemBuilder: (context, index) {
            var data = tugasC.tugasM?.data[index];
            return data?.submitTugas != null
                ? emptyData()
                : Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                        title: Text(
                          data!.nama,
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
                          var tenggat = data.tenggat;
                          int year = int.parse(tenggat.getYear());
                          int month = int.parse(tenggat.getMonthNumber());
                          int day = int.parse(tenggat.getTgl());

                          await getCurrentTime();

                          DateTime batasTanggal = DateTime(year, month, day);

                          if (dateNow!.isAfter(batasTanggal)) {
                            snackbarfailed(
                                "Batas waktu sudah lewat, tidak bisa mengumpulkan tugas.");
                          } else {
                            Get.toNamed(
                              AppRoutes.tugasCommitSiswa,
                              arguments: data.id,
                            )?.then((value) {
                              if (value == true) {
                                // Panggil ulang controller atau refresh data di halaman ini
                                tugasC.getTugas(id: Get.arguments);
                              }
                            });
                          }
                        }),
                  );
          },
        );
      }
    });
  }

  Center emptyData() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 100),
        child: MyText(
            text: "Tidak Ada Tugas",
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Obx tugasSelesai() {
    return Obx(() {
      if (tugasC.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (tugasC.tugasM?.data.isEmpty ?? true) {
        return emptyData();
      } else {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          itemCount: tugasC.tugasM?.data.length ?? 0,
          itemBuilder: (context, index) {
            var data = tugasC.tugasM?.data[index];
            return data?.submitTugas == null
                ? emptyData()
                : Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                        title: Text(
                          data!.nama,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              const SizedBox(height: 10),
                              MyText(
                                text:
                                    "Tanggal Pengumpulan : ${data.submitTugas!.tanggal.simpleDateRevers()}",
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                        onTap: () async {
                          Get.toNamed(AppRoutes.tugasCommitSiswa);
                        }),
                  );
          },
        );
      }
    });
  }
}
