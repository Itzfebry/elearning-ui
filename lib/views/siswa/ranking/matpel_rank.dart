// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/siswa/matapelajaran/controllers/mata_pelajaran_simple_controller.dart';
import 'package:ui/widgets/my_text.dart';

class MatpelRank extends StatelessWidget {
  MatpelRank({super.key});
  MataPelajaranSimpleController matapelajaranSimpleC =
      Get.find<MataPelajaranSimpleController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          "Matapelajaran Quiz",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF667EEA),
                Color(0xFF764BA2),
              ],
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF667EEA),
                      Color(0xFF764BA2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF667EEA).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.quiz,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Quiz Ranking",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Text(
                            "Lihat peringkat quiz mata pelajaran",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              Expanded(
                child: Obx(
                  () {
                    if (matapelajaranSimpleC.isLoading.value) {
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
                                  Color(0xFF667EEA),
                                ),
                                strokeWidth: 3,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Memuat data...",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (matapelajaranSimpleC
                            .mataPelajaranSimpleM?.data.isEmpty ??
                        true) {
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
                                      color: const Color(0xFF667EEA)
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Icon(
                                      Icons.quiz_outlined,
                                      size: 60,
                                      color: Color(0xFF667EEA),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const MyText(
                                    text: "Tidak Ada Mata Pelajaran",
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "Belum ada mata pelajaran yang tersedia",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: matapelajaranSimpleC
                                  .mataPelajaranSimpleM?.data.length ??
                              0,
                          itemBuilder: (context, index) {
                            var data = matapelajaranSimpleC
                                .mataPelajaranSimpleM?.data[index];
                            return TaskItem(
                              id: data!.id.toString(),
                              title: data.nama,
                              guru: data.guru.nama,
                              mataPelajaranId: data.id.toString(),
                              index: index,
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
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
  final String guru;
  final String mataPelajaranId;
  final int index;

  const TaskItem({
    super.key,
    required this.id,
    required this.title,
    required this.guru,
    required this.mataPelajaranId,
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

  List<Color> _getGradientColors(int index) {
    List<List<Color>> gradients = [
      [const Color(0xFF667EEA), const Color(0xFF764BA2)],
      [const Color(0xFF43E97B), const Color(0xFF38F9D7)],
      [const Color(0xFFFA709A), const Color(0xFFFEE140)],
      [const Color(0xFF30CFD0), const Color(0xFFA8EDEA)],
      [const Color(0xFFFFCCDB), const Color(0xFFFFEFBA)],
      [const Color(0xFFFF9A9E), const Color(0xFFFECFEF)],
    ];
    return gradients[index % gradients.length];
  }

  IconData _getSubjectIcon(String subject) {
    String subjectLower = subject.toLowerCase();
    if (subjectLower.contains('matematika') || subjectLower.contains('math')) {
      return Icons.calculate;
    } else if (subjectLower.contains('fisika') ||
        subjectLower.contains('physics')) {
      return Icons.science;
    } else if (subjectLower.contains('kimia') ||
        subjectLower.contains('chemistry')) {
      return Icons.biotech;
    } else if (subjectLower.contains('biologi') ||
        subjectLower.contains('biology')) {
      return Icons.eco;
    } else if (subjectLower.contains('bahasa') ||
        subjectLower.contains('language')) {
      return Icons.translate;
    } else if (subjectLower.contains('sejarah') ||
        subjectLower.contains('history')) {
      return Icons.history_edu;
    } else if (subjectLower.contains('geografi') ||
        subjectLower.contains('geography')) {
      return Icons.public;
    } else if (subjectLower.contains('seni') || subjectLower.contains('art')) {
      return Icons.palette;
    } else if (subjectLower.contains('olahraga') ||
        subjectLower.contains('sport')) {
      return Icons.sports;
    } else {
      return Icons.quiz;
    }
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors = _getGradientColors(widget.index);

    return GestureDetector(
      onTapDown: (_) {
        _animationController.forward();
      },
      onTapUp: (_) {
        _animationController.reverse();
        Get.toNamed(AppRoutes.matpelQuizRankDetail, arguments: {
          'matpel_id': widget.id,
          'matpel': widget.title,
        });
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
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        _getSubjectIcon(widget.title),
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    "Guru : ${widget.guru}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.leaderboard,
                        color: Colors.white,
                        size: 16,
                      ),
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
}
