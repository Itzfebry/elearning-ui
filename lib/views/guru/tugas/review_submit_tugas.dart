import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:ui/widgets/my_date_format.dart';
import 'package:ui/widgets/my_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ReviewSubmitTugas extends StatelessWidget {
  const ReviewSubmitTugas({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
        enableJavaScript: true,
      ),
    )) {
      throw Exception('Could not launch $url');
    }
  }

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
              child: Column(
                children: [
                  const Text(
                    "Soal : ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    Get.arguments['title'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const MyText(
                text: "Jawaban Siswa :",
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w600),
            if (Get.arguments['text'] == null)
              InkWell(
                onTap: () {
                  _launchUrl(
                      "${ApiConstants.baseUrl}/storage/${Get.arguments['file']}");
                },
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    SizedBox(
                      width: Get.width,
                      child: const MyText(
                          text: "Klik disini untuk Lihat File",
                          fontSize: 15,
                          color: Colors.blue,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            if (Get.arguments['file'] == null)
              Column(
                children: [
                  const SizedBox(height: 5),
                  MyText(
                      text: Get.arguments['text'],
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ],
              ),
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MyText(
                    text: "Tanggal pengempulan :",
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
                const SizedBox(height: 5),
                MyText(
                    text: DateTime.parse(
                            Get.arguments['tanggal_pengumpulan'].toString())
                        .simpleDateRevers(),
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ],
            )
          ],
        ),
      ),
    );
  }
}
