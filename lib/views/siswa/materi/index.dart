import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/views/siswa/materi/controllers/materi_controller.dart';
import 'package:ui/widgets/my_date_format.dart';
import 'package:url_launcher/url_launcher.dart';

class MateriView extends StatefulWidget {
  const MateriView({super.key});

  @override
  State<MateriView> createState() => _MateriViewState();
}

class _MateriViewState extends State<MateriView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  MateriController materiC = Get.find<MateriController>();

  String? selectedSemester = "1";
  String? selectedSemesterVideo = "1";
  final List<String> semesterList = ['1', '2'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    log(Get.arguments.toString());

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;

      if (_tabController.index == 0 && !materiC.isMateriLoaded.value) {
        materiC.getMateriBuku(
            idMatpel: Get.arguments, semester: selectedSemester);
        log("Materi");
      } else if (_tabController.index == 1 && !materiC.isVideoLoaded.value) {
        log("VIdeo");
        materiC.getMateriVideo(
            idMatpel: Get.arguments, semester: selectedSemesterVideo);
      }
    });

    materiC.getMateriBuku(idMatpel: Get.arguments, semester: selectedSemester);
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Materi & Video'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Materi', icon: Icon(Icons.book)),
            Tab(text: 'Video', icon: Icon(Icons.video_collection)),
          ],
        ),
      ),
      body: Obx(
        () => TabBarView(
          controller: _tabController,
          children: [
            // Tab Materi
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Pilih Semester',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                    value: selectedSemester ?? "1",
                    items: semesterList.map((semester) {
                      return DropdownMenuItem<String>(
                        value: semester,
                        child: Text('Semester $semester'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSemester = value!;
                      });
                      materiC.getMateriBuku(
                          idMatpel: Get.arguments, semester: selectedSemester);
                    },
                  ),
                ),
                if (materiC.isLoadingBuku.value)
                  const Center(child: CircularProgressIndicator())
                else if (materiC.materiBuku == null ||
                    materiC.materiBuku!.data.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(child: Text('Tidak ada materi')),
                  )
                else
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    shrinkWrap: true,
                    itemCount: materiC.materiBuku?.data.length ?? 0,
                    itemBuilder: (context, index) {
                      final materi = materiC.materiBuku!.data;
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                materi[index].judulMateri,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                  'Tanggal: ${materi[index].tanggal.simpleDateRevers()}'),
                              const SizedBox(height: 12),
                              ElevatedButton.icon(
                                onPressed: () async {
                                  await materiC.downloadPdfWithHttp(
                                    materi[index].path,
                                    materi[index].judulMateri,
                                    materi[index].semester,
                                  );
                                },
                                icon: const Icon(Icons.download),
                                label: const Text("Download Materi"),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),

            // Tab Video
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Pilih Semester',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                    value: selectedSemesterVideo ?? "1",
                    items: semesterList.map((semester) {
                      return DropdownMenuItem<String>(
                        value: semester,
                        child: Text('Semester $semester'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSemesterVideo = value!;
                      });
                      materiC.getMateriVideo(
                          idMatpel: Get.arguments,
                          semester: selectedSemesterVideo);
                    },
                  ),
                ),
                if (materiC.isLoadingVideo.value)
                  const Center(child: CircularProgressIndicator())
                else if (materiC.materiVideo == null ||
                    materiC.materiVideo!.data.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(child: Text('Tidak ada materi video')),
                  )
                else
                  ListView.builder(
                    padding: const EdgeInsets.all(12),
                    shrinkWrap: true,
                    itemCount: materiC.materiVideo?.data.length ?? 0,
                    itemBuilder: (context, index) {
                      final video = materiC.materiVideo!.data[index];
                      final videoId =
                          Uri.parse(video.path).queryParameters['v'];
                      final thumbnailUrl =
                          'https://img.youtube.com/vi/$videoId/0.jpg';

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              _launchUrl(video.path);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(thumbnailUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.play_circle_fill,
                                  color: Colors.white,
                                  size: 60,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              video.judulMateri,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(video.deskripsi),
                          const SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
