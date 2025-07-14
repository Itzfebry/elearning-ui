import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/views/siswa/ranking/controllers/ranking_controller.dart';
import 'package:ui/widgets/my_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RankSiswa extends StatelessWidget {
  // final List<Map<String, dynamic>> ranking = [
  //   {"name": "Febry", "rank": 1, "score": 93},
  //   {"name": "Udin", "rank": 2},
  //   {"name": "Umar", "rank": 3},
  //   {"name": "Dina", "rank": 4},
  //   {"name": "Rafi", "rank": 5},
  // ];

  RankSiswa({super.key});

  Color getMedalColor(int rank) {
    switch (rank) {
      case 1:
        return const Color(0xFFFFD700); // Gold
      case 2:
        return const Color(0xFFC0C0C0); // Silver
      case 3:
        return const Color(0xFFCD7F32); // Bronze
      default:
        return const Color(0xFF667EEA); // Default blue
    }
  }

  String getMedalEmoji(int rank) {
    switch (rank) {
      case 1:
        return '🥇';
      case 2:
        return '🥈';
      case 3:
        return '🥉';
      default:
        return '🎯';
    }
  }

  RankingController rankingC = Get.find<RankingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          "Ranking Siswa",
          style: const TextStyle(
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
        child: RefreshIndicator(
          onRefresh: () async {
            await rankingC.refreshData();
          },
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
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.emoji_events,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "🏆 Ranking Siswa",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        Get.arguments['judul'] ?? "Quiz Ranking",
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Ranking List
                Expanded(
                  child: Obx(() {
                    if (rankingC.isLoading.value) {
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
                              "Memuat data ranking...",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    if (rankingC.isEmpty.value) {
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
                                      Icons.emoji_events_outlined,
                                      size: 60,
                                      color: Color(0xFF667EEA),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const MyText(
                                    text: "Belum Ada Ranking",
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "Belum ada siswa yang mengerjakan quiz ini",
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
                    }

                    var data = rankingC.leaderboard;
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.white,
                                      getMedalColor(index + 1)
                                          .withOpacity(0.05),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: getMedalColor(index + 1)
                                          .withOpacity(0.1),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                  border: Border.all(
                                    color: getMedalColor(index + 1)
                                        .withOpacity(0.1),
                                    width: 1,
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    children: [
                                      // Rank Badge
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              getMedalColor(index + 1),
                                              getMedalColor(index + 1)
                                                  .withOpacity(0.7),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color: getMedalColor(index + 1)
                                                  .withOpacity(0.3),
                                              blurRadius: 10,
                                              offset: const Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            getMedalEmoji(index + 1),
                                            style:
                                                const TextStyle(fontSize: 24),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      // Student Info
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data[index]['nama'],
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins',
                                                color: Color(0xFF2D3748),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "Peringkat " +
                                                  (index + 1).toString(),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: getMedalColor(index + 1),
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Score
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              getMedalColor(index + 1),
                                              getMedalColor(index + 1)
                                                  .withOpacity(0.7),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color: getMedalColor(index + 1)
                                                  .withOpacity(0.3),
                                              blurRadius: 10,
                                              offset: const Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            const Text(
                                              "Skor",
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              "${data[index]['skor']}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Skor Pribadi - tampilan profesional
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.symmetric(
                              vertical: 24, horizontal: 24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.08),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ],
                            border: Border.all(
                                color:
                                    const Color(0xFF667EEA).withOpacity(0.12)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF667EEA).withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(Icons.person,
                                    color: Color(0xFF667EEA), size: 36),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Skor Anda',
                                      style: TextStyle(
                                        color: Color(0xFF667EEA),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Obx(() => Text(
                                          rankingC.myScore.value,
                                          style: const TextStyle(
                                            color: Color(0xFF222B45),
                                            fontSize: 36,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: 'Poppins',
                                            letterSpacing: 1.2,
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
