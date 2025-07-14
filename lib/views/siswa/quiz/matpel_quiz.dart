// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/siswa/matapelajaran/controllers/mata_pelajaran_simple_controller.dart';
import 'package:ui/widgets/my_text.dart';

class MatpelQuiz extends StatelessWidget {
  MatpelQuiz({super.key});
  MataPelajaranSimpleController matapelajaranSimpleC =
      Get.find<MataPelajaranSimpleController>();

  @override
  Widget build(BuildContext context) {
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
            const Text(
              "Quiz Challenge",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 22,
                color: Colors.white,
                letterSpacing: 0.5,
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
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quiz List
              Expanded(
                child: Obx(() {
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
                                Color(0xFF6366F1),
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
                  } else if (matapelajaranSimpleC.isEmptyData.value) {
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
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: matapelajaranSimpleC
                              .mataPelajaranSimpleM?.data.length ??
                          0,
                      itemBuilder: (context, index) {
                        var data = matapelajaranSimpleC
                            .mataPelajaranSimpleM?.data[index];
                        return QuizSubjectCard(
                          id: data!.id.toString(),
                          title: data.nama,
                          guru: data.guru.nama,
                          mataPelajaranId: data.id.toString(),
                          index: index,
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

class QuizSubjectCard extends StatefulWidget {
  final String id;
  final String title;
  final String guru;
  final String mataPelajaranId;
  final int index;

  const QuizSubjectCard({
    super.key,
    required this.id,
    required this.title,
    required this.guru,
    required this.mataPelajaranId,
    required this.index,
  });

  @override
  State<QuizSubjectCard> createState() => _QuizSubjectCardState();
}

class _QuizSubjectCardState extends State<QuizSubjectCard>
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
      [const Color(0xFFF093FB), const Color(0xFFF5576C)],
      [const Color(0xFF4FACFE), const Color(0xFF00F2FE)],
      [const Color(0xFF43E97B), const Color(0xFF38F9D7)],
      [const Color(0xFFFA709A), const Color(0xFFFEE140)],
      [const Color(0xFFA8EDEA), const Color(0xFFFED6E3)],
      [const Color(0xFFFF9A9E), const Color(0xFFFECFEF)],
      [const Color(0xFFA8CABA), const Color(0xFF5D4E75)],
    ];
    return gradients[index % gradients.length];
  }

  IconData _getSubjectQuizIcon(String subject) {
    String subjectLower = subject.toLowerCase();
    if (subjectLower.contains('matematika') || subjectLower.contains('math')) {
      return Icons.functions;
    } else if (subjectLower.contains('fisika') ||
        subjectLower.contains('physics')) {
      return Icons.science_outlined;
    } else if (subjectLower.contains('kimia') ||
        subjectLower.contains('chemistry')) {
      return Icons.biotech_outlined;
    } else if (subjectLower.contains('biologi') ||
        subjectLower.contains('biology')) {
      return Icons.nature_people;
    } else if (subjectLower.contains('bahasa') ||
        subjectLower.contains('language')) {
      return Icons.translate_outlined;
    } else if (subjectLower.contains('sejarah') ||
        subjectLower.contains('history')) {
      return Icons.history_edu_outlined;
    } else if (subjectLower.contains('geografi') ||
        subjectLower.contains('geography')) {
      return Icons.public_outlined;
    } else if (subjectLower.contains('seni') || subjectLower.contains('art')) {
      return Icons.palette_outlined;
    } else if (subjectLower.contains('olahraga') ||
        subjectLower.contains('sport')) {
      return Icons.sports_outlined;
    } else {
      return Icons.quiz_outlined;
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
        Get.toNamed(AppRoutes.matpelQuizDetail, arguments: {
          'matpel_id': widget.mataPelajaranId,
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
                        _getSubjectQuizIcon(widget.title),
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
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
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
                            child: const Text(
                              "Quiz Level",
                              style: TextStyle(
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
              ),
            ),
          );
        },
      ),
    );
  }
}
