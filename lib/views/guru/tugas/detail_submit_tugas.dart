import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntp/ntp.dart';
import 'package:ui/views/guru/tugas/controllers/detail_submit_tugas_siswa_controller.dart';
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
      appBar: AppBar(title: const Text("Detail Tugas")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: buttonTab(),
          ),
          if (isActive == "selesai") tugasSelesai(),
          if (isActive == "belum") tugasBelum(),
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
        GestureDetector(
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
      ],
    );
  }

  Obx tugasBelum() {
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
          shrinkWrap: true,
          itemCount:
              detailSubTugasSiswaC.detailSubmitTugasSiswaM?.data.length ?? 0,
          itemBuilder: (context, index) {
            var data =
                detailSubTugasSiswaC.detailSubmitTugasSiswaM?.data[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                title: Text(
                  data!.nama,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                // subtitle: Padding(
                //   padding: const EdgeInsets.only(top: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       MyText(
                //         text: data.tanggal.simpleDateRevers(),
                //         fontSize: 14,
                //         color: Colors.black,
                //         fontWeight: FontWeight.w600,
                //       ),
                //       MyText(
                //         text:
                //             "Tenggat : ${data.tenggat.simpleDateRevers()}",
                //         fontSize: 14,
                //         color: Colors.red,
                //         fontWeight: FontWeight.w600,
                //       )
                //     ],
                //   ),
                // ),
                onTap: () async {},
              ),
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
            text: "Tidak Ada Siswa",
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Obx tugasSelesai() {
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
          shrinkWrap: true,
          itemCount:
              detailSubTugasSiswaC.detailSubmitTugasSiswaM?.data.length ?? 0,
          itemBuilder: (context, index) {
            var data =
                detailSubTugasSiswaC.detailSubmitTugasSiswaM?.data[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                title: Text(
                  data!.nama,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                // subtitle: Padding(
                //   padding: const EdgeInsets.only(top: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       MyText(
                //         text: data.tanggal.simpleDateRevers(),
                //         fontSize: 14,
                //         color: Colors.black,
                //         fontWeight: FontWeight.w600,
                //       ),
                //       MyText(
                //         text:
                //             "Tenggat : ${data.tenggat.simpleDateRevers()}",
                //         fontSize: 14,
                //         color: Colors.red,
                //         fontWeight: FontWeight.w600,
                //       )
                //     ],
                //   ),
                // ),
                onTap: () async {},
              ),
            );
          },
        );
      }
    });
  }
}
