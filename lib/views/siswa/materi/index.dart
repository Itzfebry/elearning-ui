import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/constans/constansts_export.dart';
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
      backgroundColor: AppTheme.neutralGrey.withOpacity(0.3),
      appBar: AppBar(
        title: const Text(
          'Materi & Video',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.neutralWhite,
          ),
        ),
        backgroundColor: AppTheme.primaryGreen,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppTheme.primaryGreenDark,
          ),
          labelColor: AppTheme.neutralWhite,
          unselectedLabelColor: AppTheme.neutralWhite.withOpacity(0.7),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          tabs: const [
            Tab(
              text: 'Materi',
              icon: Icon(Icons.book, size: 20),
            ),
            Tab(
              text: 'Video',
              icon: Icon(Icons.video_library, size: 20),
            ),
          ],
        ),
      ),
      body: Obx(
        () => TabBarView(
          controller: _tabController,
          children: [
            // Tab Materi
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Semester Selector with Custom Style
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 16),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppTheme.neutralWhite,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Pilih Semester',
                        labelStyle: const TextStyle(
                          color: AppTheme.primaryGreen,
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: const Icon(
                          Icons.calendar_today,
                          color: AppTheme.primaryGreen,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        filled: true,
                        fillColor: AppTheme.neutralWhite,
                      ),
                      dropdownColor: AppTheme.neutralWhite,
                      value: selectedSemester ?? "1",
                      items: semesterList.map((semester) {
                        return DropdownMenuItem<String>(
                          value: semester,
                          child: Text(
                            'Semester $semester',
                            style: const TextStyle(
                              color: AppTheme.neutralBlack,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSemester = value!;
                        });
                        materiC.getMateriBuku(
                            idMatpel: Get.arguments,
                            semester: selectedSemester);
                      },
                    ),
                  ),

                  // Materials List
                  if (materiC.isLoadingBuku.value)
                    const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                    )
                  else if (materiC.materiBuku == null ||
                      materiC.materiBuku!.data.isEmpty)
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.book_outlined,
                              size: 80,
                              color: AppTheme.neutralDarkGrey.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Tidak ada materi',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppTheme.neutralDarkGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        itemCount: materiC.materiBuku?.data.length ?? 0,
                        itemBuilder: (context, index) {
                          final materi = materiC.materiBuku!.data;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: AppTheme.neutralWhite,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Material Header
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Document Icon
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: AppTheme.primaryGreenLight
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Icon(
                                          Icons.description,
                                          color: AppTheme.primaryGreen,
                                          size: 28,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      // Material Title and Date
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              materi[index].judulMateri,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: AppTheme.neutralBlack,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.calendar_month,
                                                  size: 14,
                                                  color:
                                                      AppTheme.neutralDarkGrey,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  materi[index]
                                                      .tanggal
                                                      .fullDateTime(),
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: AppTheme
                                                        .neutralDarkGrey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Download Button
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF5F7FA),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                  ),
                                  child: ElevatedButton.icon(
                                    onPressed: () async {
                                      await materiC.downloadPdfWithHttp(
                                        materi[index].path,
                                        materi[index].judulMateri,
                                        materi[index].semester,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppTheme.primaryGreen,
                                      foregroundColor: AppTheme.neutralWhite,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    icon: const Icon(Icons.download, size: 18),
                                    label: const Text(
                                      "Download Materi",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),

            // Tab Video
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Semester Selector with Custom Style
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 16),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppTheme.neutralWhite,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Pilih Semester',
                        labelStyle: const TextStyle(
                          color: AppTheme.primaryGreen,
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: const Icon(
                          Icons.calendar_today,
                          color: AppTheme.primaryGreen,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        filled: true,
                        fillColor: AppTheme.neutralWhite,
                      ),
                      dropdownColor: AppTheme.neutralWhite,
                      value: selectedSemesterVideo ?? "1",
                      items: semesterList.map((semester) {
                        return DropdownMenuItem<String>(
                          value: semester,
                          child: Text(
                            'Semester $semester',
                            style: const TextStyle(
                              color: AppTheme.neutralBlack,
                            ),
                          ),
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

                  // Video List
                  if (materiC.isLoadingVideo.value)
                    const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                    )
                  else if (materiC.materiVideo == null ||
                      materiC.materiVideo!.data.isEmpty)
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.videocam_off,
                              size: 80,
                              color: AppTheme.neutralDarkGrey.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Tidak ada materi video',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppTheme.neutralDarkGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        itemCount: materiC.materiVideo?.data.length ?? 0,
                        itemBuilder: (context, index) {
                          final video = materiC.materiVideo!.data[index];
                          final videoId =
                              Uri.parse(video.path).queryParameters['v'];
                          final thumbnailUrl =
                              'https://img.youtube.com/vi/$videoId/0.jpg';

                          return Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: AppTheme.neutralWhite,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Video Thumbnail with Play Button
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                  child: Stack(
                                    children: [
                                      // Thumbnail
                                      Container(
                                        width: double.infinity,
                                        height: 180,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(thumbnailUrl),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      // Play Button Overlay
                                      Container(
                                        width: double.infinity,
                                        height: 180,
                                        color: Colors.black.withOpacity(0.2),
                                        child: Center(
                                          child: InkWell(
                                            onTap: () => _launchUrl(video.path),
                                            child: Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: AppTheme.accentOrange,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                    blurRadius: 10,
                                                    offset: const Offset(0, 4),
                                                  ),
                                                ],
                                              ),
                                              child: const Icon(
                                                Icons.play_arrow,
                                                color: Colors.white,
                                                size: 36,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Video Title and Description
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        video.judulMateri,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.neutralBlack,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          const Icon(Icons.calendar_today,
                                              size: 14,
                                              color: AppTheme.neutralDarkGrey),
                                          const SizedBox(width: 4),
                                          Text(
                                            video.tanggal.fullDateTime(),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color:
                                                    AppTheme.neutralDarkGrey),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // Watch Button
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF5F7FA),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                  ),
                                  child: TextButton.icon(
                                    onPressed: () => _launchUrl(video.path),
                                    style: TextButton.styleFrom(
                                      foregroundColor: AppTheme.accentBlue,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                    ),
                                    icon: const Icon(Icons.play_circle_outline),
                                    label: const Text(
                                      "Tonton di YouTube",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
