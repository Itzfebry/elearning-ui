import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:ui/widgets/my_date_format.dart';
import 'package:ui/widgets/my_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ui/views/guru/tugas/controllers/review_submit_tugas_controller.dart';

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
    final controller = Get.put(ReviewSubmitTugasController());

    // Get arguments with null safety
    final args = Get.arguments ?? {};
    final text = args['text']?.toString();
    final file = args['file']?.toString();
    final tanggalPengumpulan = args['tanggal_pengumpulan']?.toString();
    final id = args['id']?.toString();

    return Scaffold(
      appBar: AppBar(
        title: const MyText(
          text: "Review Tugas Siswa",
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: const Color(0xFF57E389),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF57E389),
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF57E389).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MyText(
                        text: "Informasi Tugas",
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 12),
                      Obx(() {
                        if (controller.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF57E389).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.assignment,
                                color: Color(0xFF57E389),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: controller.taskName.value,
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const SizedBox(height: 4),
                                  MyText(
                                    text: "ID: ${controller.taskId.value}",
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MyText(
                        text: "Jawaban Siswa",
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 12),
                      if (text == null && file != null)
                        InkWell(
                          onTap: () {
                            _launchUrl("${ApiConstants.baseUrl}/storage/$file");
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.file_present,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 12),
                                const MyText(
                                  text: "Lihat File",
                                  fontSize: 16,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.blue,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (file == null && text != null)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: MyText(
                            text: text,
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MyText(
                        text: "Informasi Pengumpulan",
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF57E389).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.calendar_today,
                              color: Color(0xFF57E389),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          MyText(
                            text: tanggalPengumpulan != null
                                ? DateTime.parse(tanggalPengumpulan)
                                    .simpleDateRevers()
                                : 'Tanggal tidak tersedia',
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MyText(
                        text: "Nilai",
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 16),
                      Obx(() => Slider(
                            value: controller.nilai.value.toDouble(),
                            min: 0,
                            max: 100,
                            divisions: 100,
                            activeColor: const Color(0xFF57E389),
                            inactiveColor:
                                const Color(0xFF57E389).withOpacity(0.2),
                            label: controller.nilai.value.toString(),
                            onChanged: (value) {
                              controller.nilai.value = value;
                            },
                          )),
                      const SizedBox(height: 8),
                      Obx(() => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF57E389).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: MyText(
                              text: "Nilai: ${controller.nilai.value}",
                              fontSize: 16,
                              color: const Color(0xFF57E389),
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: Get.width,
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value || id == null
                              ? null
                              : () {
                                  controller.updateNilai();
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF57E389),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Obx(() => controller.isLoading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const MyText(
                                  text: "Simpan Nilai",
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
