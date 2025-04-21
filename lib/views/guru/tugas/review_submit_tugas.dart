import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewSubmitTugas extends StatelessWidget {
  const ReviewSubmitTugas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Review Tugas Siswa"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF57E389),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  Text(
                    "Daur Hidup Pada Hewan:\nDari Telur Hingga Dewasa",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Berikan sebuah struktur daur hidup\nlingkungan pada bioma terdekat di sekolah",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // if (Get.arguments['tipe_tugas'] == "selesai" &&
            //     Get.arguments['submitTugas']['text'] == null)
            //   InkWell(
            //     onTap: () {
            //       _launchUrl(
            //           "${ApiConstants.baseUrl}/storage/${Get.arguments['submitTugas']['file']}");
            //     },
            //     child: Column(
            //       children: [
            //         const SizedBox(height: 10),
            //         SizedBox(
            //           width: Get.width,
            //           child: const MyText(
            //               text: "Klik disini untuk Lihat File",
            //               fontSize: 15,
            //               color: Colors.blue,
            //               fontWeight: FontWeight.w700),
            //         ),
            //       ],
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
