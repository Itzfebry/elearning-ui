import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/kelas_controller.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/mata_pelajaran_guru_controller.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/tahun_ajaran_controller.dart';

class FilterMatpel extends StatelessWidget {
  const FilterMatpel({
    super.key,
    required this.kelasC,
    required this.tahunAjaranC,
    required this.matpelGuruC,
  });

  final KelasController kelasC;
  final TahunAjaranController tahunAjaranC;
  final MataPelajaranGuruController matpelGuruC;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Obx(() {
              if (kelasC.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (kelasC.kelasM?.data == null || kelasC.kelasM!.data.isEmpty) {
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
    );
  }
}
