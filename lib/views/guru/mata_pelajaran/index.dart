// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/kelas_controller.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/mata_pelajaran_guru_controller.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/tahun_ajaran_controller.dart';
import 'package:ui/widgets/my_date_format.dart';

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
      appBar: AppBar(title: const Text("Kelas Mata Pelajaran")),
      body: Column(
        children: [
          // Filter Dropdown
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Obx(() {
                    if (kelasC.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (kelasC.kelasM?.data == null ||
                        kelasC.kelasM!.data.isEmpty) {
                      return const Text('Tidak ada data kelas');
                    }

                    return SizedBox(
                      height: 55,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Kelas',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        value: kelasC.selectedKelas.value,
                        items: kelasC.kelasM!.data.map((kelas) {
                          return DropdownMenuItem<String>(
                            value: kelas.nama,
                            child: Text(kelas.nama),
                          );
                        }).toList(),
                        onChanged: (value) {
                          kelasC.selectedKelas.value = value;
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(width: 5),
                Expanded(
                  flex: 2,
                  child: Obx(() {
                    if (tahunAjaranC.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (tahunAjaranC.tahunAjaranM?.data == null ||
                        tahunAjaranC.tahunAjaranM!.data.isEmpty) {
                      return const Text('Tidak ada data Tahun');
                    }

                    return SizedBox(
                      height: 55,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Tahun Ajaran',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        value: tahunAjaranC.selectedTahun.value,
                        items: tahunAjaranC.tahunAjaranM!.data.map((tahun) {
                          return DropdownMenuItem<String>(
                            value: tahun.tahun,
                            child: Text(tahun.tahun),
                          );
                        }).toList(),
                        onChanged: (value) {
                          tahunAjaranC.selectedTahun.value = value;
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(width: 10),
                Material(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      matpelGuruC.getMatPel(
                          kelas: kelasC.selectedKelas.value!,
                          tahunAjaran: tahunAjaranC.selectedTahun.value!);
                    },
                    child: Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.tune, // Ikon yang mirip seperti di gambar
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

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
                itemBuilder: (context, index) {
                  final data = matpelGuruC.mataPelajaranM!.data[index];
                  return GestureDetector(
                    onTap: () =>
                        Get.toNamed(AppRoutes.materiSiswa, arguments: data.id),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text("${data.jumlahBuku} Materi",
                                      style:
                                          const TextStyle(color: Colors.red)),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text("${data.jumlahVideo} Video",
                                      style:
                                          const TextStyle(color: Colors.blue),
                                      textAlign: TextAlign.center),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Diperbarui: \n${(data.materi.isNotEmpty ? data.materi.last.tanggal : data.createdAt).getSimpleDayAndDate()}",
                                    textAlign: TextAlign.end,
                                  ),
                                )
                              ],
                            ),
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
