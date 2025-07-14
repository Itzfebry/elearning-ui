// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/siswa/quiz/controllers/quiz_controller.dart';
import 'package:ui/widgets/my_text.dart';

class MatpelQuizDetail extends StatelessWidget {
  MatpelQuizDetail({super.key});
  QuizController quizC = Get.find<QuizController>();

  @override
  Widget build(BuildContext context) {
    print("QuizDetail build called");
    print("Arguments received: " + Get.arguments.toString());
    print("Arguments type: " + Get.arguments.runtimeType.toString());
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.quiz_outlined,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "Quiz ${Get.arguments['matpel']}",
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF6366F1),
                Color(0xFF8B5CF6),
                Color(0xFFEC4899),
              ],
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Obx(() {
                  if (quizC.isLoading.value) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF6366F1),
                              ),
                              strokeWidth: 3,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Memuat quiz...",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (quizC.isEmptyData.value) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF6366F1)
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(
                                    Icons.quiz_outlined,
                                    size: 60,
                                    color: Color(0xFF6366F1),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const MyText(
                                  text: "Tidak Ada Quiz",
                                  fontSize: 18,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w700,
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "Belum ada quiz yang tersedia",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    quizC.resetData();
                                    quizC.getQuiz();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF6366F1),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    "Coba Lagi",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: quizC.quizM?.data.length ?? 0,
                      itemBuilder: (context, index) {
                        var data = quizC.quizM?.data[index];
                        // Check if quiz is completed based on waktu_selesai
                        bool isCompleted =
                            data?.quizAttempt?.waktuSelesai != null;

                        return SizedBox(
                          child: TaskItem(
                            id: data!.id.toString(),
                            title: data.judul,
                            total: data.totalSoalTampil.toString(),
                            waktu: data.waktu?.toString() ?? "null",
                            status: isCompleted,
                            index: index,
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskItem extends StatefulWidget {
  final String id;
  final String title;
  final String total;
  final String waktu;
  final bool status;
  final int index;

  const TaskItem({
    super.key,
    required this.id,
    required this.title,
    required this.total,
    required this.waktu,
    required this.status,
    required this.index,
  });

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    print("QuizDetail initState called");
    print("Arguments received: " + Get.arguments.toString());
    print("Arguments type: " + Get.arguments.runtimeType.toString());
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Color> _getGradientColors(int index, bool isCompleted) {
    if (isCompleted) {
      return [const Color(0xFF2E7D8F), const Color(0xFF1B5E7A)];
    }

    List<List<Color>> gradients = [
      [const Color(0xFF4A5568), const Color(0xFF2D3748)],
      [const Color(0xFF805AD5), const Color(0xFF553C9A)],
      [const Color(0xFFE53E3E), const Color(0xFFC53030)],
      [const Color(0xFF38A169), const Color(0xFF2F855A)],
      [const Color(0xFFDD6B20), const Color(0xFFC05621)],
      [const Color(0xFF3182CE), const Color(0xFF2C5282)],
      [const Color(0xFFD69E2E), const Color(0xFFB7791F)],
      [const Color(0xFF667EEA), const Color(0xFF5A67D8)],
    ];
    return gradients[index % gradients.length];
  }

  IconData _getQuizIcon(bool isCompleted) {
    if (isCompleted) {
      return Icons.check_circle;
    }
    return Icons.quiz_outlined;
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors = _getGradientColors(widget.index, widget.status);
    bool isCompleted = widget.status;

    return GestureDetector(
      onTapDown: (_) {
        _animationController.forward();
      },
      onTapUp: (_) {
        _animationController.reverse();
        if (isCompleted) {
          // Show options for completed quiz
          _showQuizOptions(context);
        } else {
          // Start quiz, kirim juga waktu_quiz
          Get.offAllNamed(AppRoutes.soalQuiz, arguments: {
            "quiz_id": widget.id,
            "waktu_quiz": widget.waktu,
          });
        }
      },
      onTapCancel: () {
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradientColors,
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: gradientColors[0].withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0.05),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.4),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            _getQuizIcon(isCompleted),
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  isCompleted ? "Selesai" : "Belum Dikerjakan",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.help_outline,
                                  size: 16,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "${widget.total} Soal",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  size: 16,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    widget.waktu == "null"
                                        ? "Tidak dibatasi"
                                        : "${widget.waktu} menit",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
  }

  void _showQuizOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Pilih Aksi",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                      Get.toNamed(AppRoutes.quizSelesai,
                          arguments: {'quiz_id': widget.id});
                    },
                    icon: const Icon(Icons.visibility),
                    label: const Text("Lihat Hasil"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4FACFE),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                      _showRetakeConfirmation(context);
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text("Kerjakan Ulang"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF43E97B),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showRetakeConfirmation(BuildContext context) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Kerjakan Ulang Quiz',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        content: const Text(
          'Apakah Anda yakin ingin mengerjakan quiz ini lagi?\n\n• Skor sebelumnya akan tetap tersimpan\n• Anda akan mendapatkan attempt baru\n• Timer akan dimulai ulang dari awal',
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Batal',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.offAllNamed(AppRoutes.soalQuiz, arguments: {
                "quiz_id": widget.id,
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF43E97B),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Ya, Kerjakan Ulang',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
