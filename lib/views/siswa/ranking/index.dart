import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/views/siswa/ranking/controllers/ranking_controller.dart';
import 'package:ui/widgets/my_text.dart';

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
        return Colors.yellow;
      case 2:
        return Colors.amberAccent;
      case 3:
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }

  RankingController rankingC = Get.find<RankingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Ranking Siswa"),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            MyText(
                text: "QUIZ - ${Get.arguments['matpel']}",
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w900),
            const SizedBox(height: 5),
            MyText(
                text: Get.arguments['judul'],
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w700),
            const SizedBox(height: 50),
            Obx(
              () {
                if (rankingC.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var data = rankingC.data['data'];

                if (rankingC.isEmpty.value) {
                  return const Center(
                    child: Text('Tidak ada data'),
                  );
                }

                return ListView.builder(
                  itemCount: rankingC.data['data'].length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const SizedBox(height: 5),
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.teal[100],
                              child: const Icon(Icons.emoji_emotions, size: 30),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: getMedalColor(index + 1),
                                child: Text(
                                  "${index + 1}",
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(data[index]['skor']),
                        Text(data[index]['siswa']['nama']),
                      ],
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 40),
            const Text(
              'Anda',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.teal[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Obx(() => Text(
                    'SCORE\n${rankingC.skorMe.value}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
