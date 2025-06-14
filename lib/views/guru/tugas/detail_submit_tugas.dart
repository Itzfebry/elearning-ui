import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntp/ntp.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/guru/tugas/controllers/detail_submit_tugas_siswa_controller.dart';
import 'package:ui/widgets/my_date_format.dart';
import 'package:ui/widgets/my_snackbar.dart';
import 'package:ui/widgets/my_text.dart';

class DetailSubmitTugas extends StatefulWidget {
  const DetailSubmitTugas({super.key});

  @override
  State<DetailSubmitTugas> createState() => _DetailSubmitTugasState();
}

class _DetailSubmitTugasState extends State<DetailSubmitTugas> {
  // TugasController tugasC = Get.find<TugasController>();
  DetailSubmitTugasSiswaController detailSubTugasSiswaC =
      Get.find<DetailSubmitTugasSiswaController>();

  var isActive = "selesai";
  DateTime? dateNow;

  @override
  void initState() {
    super.initState();
    detailSubTugasSiswaC.getSubmitTugas(
      id: Get.arguments['id'],
      type: "selesai",
      kelas: Get.arguments['kelas'],
      tahunAjaran: Get.arguments['tahun_ajaran'],
    );
  }

  Future<void> getCurrentTime() async {
    DateTime now = await NTP.now();
    dateNow = DateTime(now.year, now.month, now.day);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyText(
          text: "Detail Pengumpulan Tugas",
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
              Padding(
                padding: const EdgeInsets.all(20),
                child: buttonTab(),
              ),
              Expanded(
                child: isActive == "selesai" ? tugasSelesai() : tugasBelum(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonTab() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isActive = "selesai";
                });
                detailSubTugasSiswaC.getSubmitTugas(
                  id: Get.arguments['id'],
                  type: "selesai",
                  kelas: Get.arguments['kelas'],
                  tahunAjaran: Get.arguments['tahun_ajaran'],
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isActive == "selesai"
                      ? const Color(0xFF57E389)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: MyText(
                    text: "Selesai",
                    fontSize: 16,
                    color: isActive == "selesai" ? Colors.white : Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isActive = "belum";
                });
                detailSubTugasSiswaC.getSubmitTugas(
                  id: Get.arguments['id'],
                  type: "belum",
                  kelas: Get.arguments['kelas'],
                  tahunAjaran: Get.arguments['tahun_ajaran'],
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isActive == "belum"
                      ? const Color(0xFF57E389)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: MyText(
                    text: "Belum",
                    fontSize: 16,
                    color: isActive == "belum" ? Colors.white : Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tugasBelum() {
    return Obx(() {
      if (detailSubTugasSiswaC.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (detailSubTugasSiswaC.detailSubmitTugasSiswaM?.data.isEmpty ??
          true) {
        return emptyData();
      } else {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount:
              detailSubTugasSiswaC.detailSubmitTugasSiswaM?.data.length ?? 0,
          itemBuilder: (context, index) {
            var data =
                detailSubTugasSiswaC.detailSubmitTugasSiswaM?.data[index];
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
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: MyText(
                    text: "${index + 1}",
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                title: MyText(
                  text: data!.nama,
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const MyText(
                    text: "Belum",
                    fontSize: 12,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () async {
                  snackbarfailed("Siswa ini tidak mengumpulkan tugas");
                },
              ),
            );
          },
        );
      }
    });
  }

  Widget emptyData() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          const MyText(
            text: "Tidak Ada Siswa",
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  Widget tugasSelesai() {
    return Obx(() {
      if (detailSubTugasSiswaC.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (detailSubTugasSiswaC.detailSubmitTugasSiswaM?.data.isEmpty ??
          true) {
        return emptyData();
      } else {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount:
              detailSubTugasSiswaC.detailSubmitTugasSiswaM?.data.length ?? 0,
          itemBuilder: (context, index) {
            var data =
                detailSubTugasSiswaC.detailSubmitTugasSiswaM?.data[index];
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
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF57E389).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: MyText(
                    text: "${index + 1}",
                    fontSize: 16,
                    color: const Color(0xFF57E389),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: data!.nama,
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 4),
                    MyText(
                      text: data.submitTugas!.tanggal.simpleDateRevers(),
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: data.submitTugas!.nilai != null
                        ? const Color(0xFF57E389).withOpacity(0.1)
                        : Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: MyText(
                    text: data.submitTugas!.nilai != null
                        ? "Nilai: ${data.submitTugas!.nilai}"
                        : "Belum dinilai",
                    fontSize: 12,
                    color: data.submitTugas!.nilai != null
                        ? const Color(0xFF57E389)
                        : Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Get.toNamed(
                    AppRoutes.reviewSubmitTugasSiswaOnGuru,
                    arguments: {
                      'id': data.submitTugas!.id,
                      'id_tugas': data.submitTugas!.tugasId,
                      'nama': data.submitTugas!.tugas.nama,
                      'text': data.submitTugas!.text,
                      'file': data.submitTugas!.file,
                      'tanggal_pengumpulan': data.submitTugas!.tanggal,
                      'nisn': data.nisn,
                    },
                  );
                },
              ),
            );
          },
        );
      }
    });
  }
}
