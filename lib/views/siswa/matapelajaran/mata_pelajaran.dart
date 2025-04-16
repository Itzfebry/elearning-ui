// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/siswa/matapelajaran/controllers/mata_pelajaran_controller.dart';
import 'package:ui/widgets/my_date_format.dart';

class KelasMataPelajaranPage extends StatelessWidget {
  KelasMataPelajaranPage({super.key});

  MataPelajaranController mataPelajaranC = Get.find<MataPelajaranController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kelas Mata Pelajaran")),
      body: Obx(() {
        if (mataPelajaranC.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: mataPelajaranC.mataPelajaranM!.data.length,
          itemBuilder: (context, index) {
            final data = mataPelajaranC.mataPelajaranM!.data;
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
                        data[index].nama,
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
