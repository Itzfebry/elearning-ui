import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/kelas_controller.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/tahun_ajaran_controller.dart';
import 'package:ui/views/guru/tugas/controllers/tugas_detail_guru_controller.dart';

class FilterTugas extends StatelessWidget {
  const FilterTugas({
    super.key,
    required this.idMatpel,
    required this.kelasC,
    required this.tahunAjaranC,
    required this.tugasSubmitDetailGuruC,
  });

  final String idMatpel;
  final KelasController kelasC;
  final TahunAjaranController tahunAjaranC;
  final TugasDetailGuruController tugasSubmitDetailGuruC;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Row(
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
                  onTap: () async {
                    await tugasSubmitDetailGuruC.getTugas(
                      id: idMatpel,
                      kelas: kelasC.selectedKelas.value,
                      tahunAjaran: tahunAjaranC.selectedTahun.value,
                    );
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
          // const SizedBox(height: 15),
          // Row(
          //   children: [
          // Expanded(
          //   flex: 3,
          //   child: SizedBox(
          //     height: 55,
          //     child: DropdownButtonFormField<String>(
          //       decoration: InputDecoration(
          //         labelText: 'Tipe Tugas',
          //         border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(10),
          //         ),
          //       ),
          //       value: tugasSubmitDetailGuruC.selectedTypeTugas.value,
          //       items: ["belum", "selesai"].map((type) {
          //         return DropdownMenuItem<String>(
          //           value: type,
          //           child: Text(type),
          //         );
          //       }).toList(),
          //       onChanged: (value) {
          //         tugasSubmitDetailGuruC.selectedTypeTugas.value = value;
          //       },
          //     ),
          //   ),
          // ),

          //   ],
          // )
        ],
      ),
    );
  }
}
