// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/mata_pelajaran_guru_controller.dart';
import 'package:ui/widgets/my_date_format.dart';

class MataPelajaranGuru extends StatefulWidget {
  const MataPelajaranGuru({super.key});

  @override
  State<MataPelajaranGuru> createState() => _MataPelajaranGuruState();
}

class _MataPelajaranGuruState extends State<MataPelajaranGuru> {
  MataPelajaranGuruController matpelGuruC =
      Get.find<MataPelajaranGuruController>();

  @override
  void initState() {
    super.initState();
    matpelGuruC.getMatPel(kelas: "6A");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kelas Mata Pelajaran")),
      body: Obx(() {
        if (matpelGuruC.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (matpelGuruC.isEmptyData.value) {
          return const Center(child: Text("Data Kosong"));
        }
        return ListView.builder(
          itemCount: matpelGuruC.mataPelajaranM?.data.length ?? 0,
          itemBuilder: (context, index) {
            final data = matpelGuruC.mataPelajaranM?.data;
            return GestureDetector(
              onTap: () =>
                  Get.toNamed(AppRoutes.materiSiswa, arguments: data[index].id),
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data![index].nama,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text("Guru: ${data[index].guru.nama}"),
                      // const Text("Semester: 1"),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text("${data[index].jumlahBuku} Materi",
                                style: const TextStyle(color: Colors.red)),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text("${data[index].jumlahVideo} Video",
                                style: const TextStyle(color: Colors.blue),
                                textAlign: TextAlign.center),
                          ),
                          if (data[index].materi.isNotEmpty)
                            Expanded(
                              flex: 2,
                              child: Text(
                                  "Diperbarui: \n${data[index].materi.last.tanggal.getSimpleDayAndDate()}",
                                  textAlign: TextAlign.end),
                            )
                          else
                            Expanded(
                              flex: 2,
                              child: Text(
                                  "Diperbarui: \n${data[index].createdAt.getSimpleDayAndDate()}",
                                  textAlign: TextAlign.end),
                            )
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
    );
  }
}
