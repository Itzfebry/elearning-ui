import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/kelas_controller.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/tahun_ajaran_controller.dart';
import 'package:ui/views/guru/tugas/controllers/tugas_detail_guru_controller.dart';
import 'package:ui/widgets/my_snackbar.dart';
import 'package:ui/widgets/my_text.dart';

class FilterTugas extends StatelessWidget {
  const FilterTugas({
    super.key,
    required this.id_matpel,
    required this.kelasC,
    required this.tahunAjaranC,
    required this.tugasDetailGuruC,
  });

  final String id_matpel;
  final KelasController kelasC;
  final TahunAjaranController tahunAjaranC;
  final TugasDetailGuruController tugasDetailGuruC;

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
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 55,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Tipe Tugas',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    value: tugasDetailGuruC.selectedTypeTugas.value,
                    items: ["belum", "selesai"].map((type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      tugasDetailGuruC.selectedTypeTugas.value = value;
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    if (tugasDetailGuruC.selectedTypeTugas.value == null) {
                      snackbarfailed("Tipe Tugas wajib di isi!");
                    } else {
                      tugasDetailGuruC.getTugas(
                        id: id_matpel,
                        type: tugasDetailGuruC.selectedTypeTugas.value,
                        kelas: kelasC.selectedKelas.value,
                        tahunAjaran: tahunAjaranC.selectedTahun.value,
                      );
                    }
                  },
                  child: Container(
                    width: 110,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.tune, // Ikon yang mirip seperti di gambar
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        MyText(
                          text: "Filter",
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
