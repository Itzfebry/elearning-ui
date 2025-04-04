import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/controllers/kelasmatapelajarans_controller.dart';
import 'package:ui/models/kelasmatapelajarans.dart';
import 'package:ui/views/siswa/matapelajaran/materi_siswa.dart';
import 'package:ui/views/siswa/matapelajaran/video_siswa.dart';

class KelasMataPelajaranPage extends StatelessWidget {
  final KelasMataPelajaranController controller =
      Get.find<KelasMataPelajaranController>();

  KelasMataPelajaranPage({super.key});

  void _showOptions(
      BuildContext context, KelasMataPelajaran kelasMataPelajaran) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Pilih kategori untuk ${kelasMataPelajaran.mataPelajaranId}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.book),
                label: const Text("Materi"),
                onPressed: () {
                  // Get.back();
                  // Get.to(() => MaterisSiswaPage(kelasMataPelajaranId: kelasMataPelajaran.id));
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                icon: const Icon(Icons.video_library),
                label: const Text("Video"),
                onPressed: () {
                  // Get.back();
                  // Get.to(() => VideosSiswaPage(kelasMataPelajaranId: kelasMataPelajaran.id));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kelas Mata Pelajaran")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.kelasMataPelajaranList.length,
          itemBuilder: (context, index) {
            final kelasMataPelajaran = controller.kelasMataPelajaranList[index];
            return GestureDetector(
              onTap: () => _showOptions(context, kelasMataPelajaran),
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
                        kelasMataPelajaran.mataPelajaranId,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text("Guru: ${kelasMataPelajaran.guruId}"),
                      Text(
                          "Semester: ${kelasMataPelajaran.semester.toString()}"),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                                "${kelasMataPelajaran.materiCount} Materi",
                                style: const TextStyle(color: Colors.red)),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                                "${kelasMataPelajaran.videoCount} Video",
                                style: const TextStyle(color: Colors.blue),
                                textAlign: TextAlign.center),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                                "Diperbarui: ${kelasMataPelajaran.lastUpdated}",
                                textAlign: TextAlign.end),
                          ),
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
