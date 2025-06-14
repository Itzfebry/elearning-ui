// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/constans/constansts_export.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/siswa/matapelajaran/controllers/mata_pelajaran_controller.dart';
import 'package:ui/widgets/my_date_format.dart';

class KelasMataPelajaranPage extends StatelessWidget {
  KelasMataPelajaranPage({super.key});

  MataPelajaranController mataPelajaranC = Get.find<MataPelajaranController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mata Pelajaran",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.neutralWhite,
          ),
        ),
        backgroundColor: AppTheme.primaryGreen,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header Section with green background
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 30,
            ),
            decoration: const BoxDecoration(
              gradient: AppTheme.greenGradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pilih Mata Pelajaran",
                    style: TextStyle(
                      color: AppTheme.neutralWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Kumpulan mata pelajaran yang dapat kamu akses",
                    style: TextStyle(
                      color: AppTheme.neutralWhite.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // List of Subjects
          Expanded(
            child: Obx(() {
              if (mataPelajaranC.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.primaryGreen,
                  ),
                );
              }
              
              if (mataPelajaranC.mataPelajaranM == null || 
                  mataPelajaranC.mataPelajaranM!.data.isEmpty) {
                return Center(
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
                        "Tidak ada mata pelajaran",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppTheme.neutralDarkGrey,
                        ),
                      ),
                    ],
                  ),
                );
              }
              
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                itemCount: mataPelajaranC.mataPelajaranM!.data.length,
                itemBuilder: (context, index) {
                  final data = mataPelajaranC.mataPelajaranM!.data;
                  // Alternate card colors for visual appeal
                  final bool isEven = index % 2 == 0;
                  
                  return GestureDetector(
                    onTap: () => Get.toNamed(
                      AppRoutes.materiSiswa, 
                      arguments: data[index].id
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        gradient: isEven
                            ? AppTheme.greenGradient
                            : null,
                        color: isEven ? null : AppTheme.neutralWhite,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Subject Header
                          Container(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Subject Icon
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isEven
                                        ? AppTheme.neutralWhite.withOpacity(0.2)
                                        : AppTheme.primaryGreenLight.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.book,
                                    color: isEven
                                        ? AppTheme.neutralWhite
                                        : AppTheme.primaryGreen,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Subject Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[index].nama,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: isEven
                                              ? AppTheme.neutralWhite
                                              : AppTheme.neutralBlack,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.person,
                                            size: 16,
                                            color: isEven
                                                ? AppTheme.neutralWhite.withOpacity(0.8)
                                                : AppTheme.neutralDarkGrey,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            data[index].guru.nama,
                                            style: TextStyle(
                                              color: isEven
                                                  ? AppTheme.neutralWhite.withOpacity(0.8)
                                                  : AppTheme.neutralDarkGrey,
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
                          
                          // Subject Footer
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: isEven
                                  ? AppTheme.neutralWhite.withOpacity(0.1)
                                  : AppTheme.neutralGrey.withOpacity(0.3),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Material Count
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppTheme.accentOrange,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.book_outlined,
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "${data[index].jumlahBuku}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    // Video Count
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppTheme.accentBlue,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.video_library,
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "${data[index].jumlahVideo}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                // Updated Date
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Diperbarui:",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: isEven
                                            ? AppTheme.neutralWhite.withOpacity(0.8)
                                            : AppTheme.neutralDarkGrey,
                                      ),
                                    ),
                                    Text(
                                      data[index].materi.isNotEmpty
                                          ? data[index].materi.last.tanggal.getSimpleDayAndDate()
                                          : data[index].createdAt.getSimpleDayAndDate(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: isEven
                                            ? AppTheme.neutralWhite
                                            : AppTheme.neutralBlack,
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
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
