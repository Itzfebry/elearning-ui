// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/kelas_controller.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/mata_pelajaran_guru_controller.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/tahun_ajaran_controller.dart';
import 'package:ui/widgets/my_text.dart';

class FilterMatpel extends StatelessWidget {
  FilterMatpel({
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
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MyText(
            text: "Filter Mata Pelajaran",
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Obx(() {
                  if (kelasC.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (kelasC.kelasM?.data == null ||
                      kelasC.kelasM!.data.isEmpty) {
                    return const Text('Tidak ada data kelas');
                  }

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        isDense: true,
                      ),
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.grey, size: 20),
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      value: kelasC.selectedKelas.value,
                      items: kelasC.kelasM!.data.map((kelas) {
                        return DropdownMenuItem<String>(
                          value: kelas.nama,
                          child: Text(
                            kelas.nama,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          kelasC.selectedKelas.value = value;
                          matpelGuruC.getMatPel(
                            kelas: value,
                            tahunAjaran: tahunAjaranC.selectedTahun.value ?? '',
                          );
                        }
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Obx(() {
                  if (tahunAjaranC.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (tahunAjaranC.tahunAjaranM?.data == null ||
                      tahunAjaranC.tahunAjaranM!.data.isEmpty) {
                    return const Text('Tidak ada data Tahun');
                  }

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        isDense: true,
                      ),
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.grey, size: 20),
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      value: tahunAjaranC.selectedTahun.value,
                      items: tahunAjaranC.tahunAjaranM!.data.map((tahun) {
                        return DropdownMenuItem<String>(
                          value: tahun.tahun,
                          child: Text(
                            tahun.tahun,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          tahunAjaranC.selectedTahun.value = value;
                          matpelGuruC.getMatPel(
                            kelas: kelasC.selectedKelas.value ?? '',
                            tahunAjaran: value,
                          );
                        }
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
