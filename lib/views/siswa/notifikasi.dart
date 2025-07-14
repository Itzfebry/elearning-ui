import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/siswa/controllers/notifikasi_controller.dart';
import 'package:ui/widgets/my_text.dart';

class NotifSiswa extends StatelessWidget {
  NotifSiswa({super.key});
  final notifC = Get.find<NotifikasiController>();

  aksi(type, {String? matapelajaranId, String? matapelajaranNama}) {
    // Jika id atau nama matapelajaran kosong/null, fallback ke daftar sesuai kategori
    if (matapelajaranId != null &&
        matapelajaranId.isNotEmpty &&
        matapelajaranNama != null &&
        matapelajaranNama.isNotEmpty) {
      switch (type) {
        case "Tugas":
          Get.toNamed(AppRoutes.tugasDetailSiswa, arguments: matapelajaranId);
          return;
        case "Quiz":
          Get.toNamed(AppRoutes.matpelQuizDetail, arguments: {
            'matpel_id': matapelajaranId,
            'matpel': matapelajaranNama,
          });
          return;
        case "Materi":
          Get.toNamed(AppRoutes.materiSiswa, arguments: matapelajaranId);
          return;
      }
    } else {
      // Fallback jika id/nama matapelajaran kosong/null
      switch (type) {
        case "Tugas":
          Get.toNamed(AppRoutes.tugasSiswa);
          return;
        case "Quiz":
          Get.toNamed(AppRoutes.matpelQuiz);
          return;
        case "Materi":
          Get.toNamed(AppRoutes.materiSiswa);
          return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          "Notifikasi",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1E293B)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (notifC.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
              ),
            );
          }

          if (notifC.dataNotif.isEmpty) {
            return _buildEmptyState();
          }

          return ListView.builder(
            itemCount: notifC.dataNotif.length,
            itemBuilder: (context, index) {
              var data = notifC.dataNotif[index];
              print('NOTIF DATA: ' + data.toString()); // Log data notifikasi
              return _buildNotificationCard(
                id: (data['id'] ?? '').toString(),
                type: data['type'] ?? '',
                judul: data['judul'] ?? '',
                isActive: data['is_active'] ?? false,
                waktu: data['created_at'] ?? '',
                matapelajaranId: data['matapelajaran_id']?.toString() ?? '',
                matapelajaranNama: data['matapelajaran_nama']?.toString() ?? '',
                index: index,
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            "Belum ada notifikasi",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Notifikasi akan muncul di sini",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard({
    required String id,
    required String type,
    required String judul,
    required bool isActive,
    required String waktu,
    String matapelajaranId = '',
    String matapelajaranNama = '',
    required int index,
  }) {
    // Animation delay based on index
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 300 + (index * 100)),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              notifC.readNotif(id: id);
              aksi(type,
                  matapelajaranId: matapelajaranId,
                  matapelajaranNama: matapelajaranNama);
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: isActive
                    ? Border.all(
                        color: _getTypeColor(type).withOpacity(0.3), width: 2)
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Icon Container
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: _getTypeColor(type).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      _getTypeIcon(type),
                      color: _getTypeColor(type),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Badge and Title Row
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getTypeColor(type),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                type,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (isActive)
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF3B82F6),
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Title
                        Text(
                          judul,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                isActive ? FontWeight.w700 : FontWeight.w600,
                            color: const Color(0xFF1E293B),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (matapelajaranNama != null &&
                            matapelajaranNama.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            matapelajaranNama,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        const SizedBox(height: 4),

                        // Time
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: Colors.grey[500],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _formatTime(waktu),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Arrow Icon
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Quiz":
        return const Color(0xFFEF4444); // Red
      case "Materi":
        return const Color(0xFF10B981); // Green
      case "Tugas":
        return const Color(0xFFF59E0B); // Amber
      default:
        return const Color(0xFF6B7280); // Gray
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "Quiz":
        return Icons.quiz_outlined;
      case "Materi":
        return Icons.menu_book_outlined;
      case "Tugas":
        return Icons.assignment_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  String _formatTime(String waktu) {
    // Simple time formatting - you can enhance this based on your needs
    try {
      final DateTime dateTime = DateTime.parse(waktu);
      final DateTime now = DateTime.now();
      final Duration difference = now.difference(dateTime);

      if (difference.inDays > 0) {
        return '${difference.inDays} hari lalu';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} jam lalu';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} menit lalu';
      } else {
        return 'Baru saja';
      }
    } catch (e) {
      return waktu;
    }
  }
}
