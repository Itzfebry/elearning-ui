import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:ui/views/siswa/tugas/controllers/submit_tugas_controller.dart';
import 'package:ui/widgets/my_text.dart';
import 'package:url_launcher/url_launcher.dart';

class TugasCommit extends StatefulWidget {
  const TugasCommit({super.key});

  @override
  State<TugasCommit> createState() => _TugasCommitState();
}

enum SubmissionMethod { file, text }

class _TugasCommitState extends State<TugasCommit> {
  String? fileName;
  File? selectedFile;
  SubmissionMethod _method = SubmissionMethod.file;
  final TextEditingController _textController = TextEditingController();
  SubmitTugasController submitTugasC = Get.find<SubmitTugasController>();

  @override
  void initState() {
    super.initState();
    if (Get.arguments['submitTugas'] != null) {
      if (Get.arguments['submitTugas']['text'] == null) {
        _method = SubmissionMethod.file;
        fileName = Get.arguments['submitTugas']['file'];
      } else {
        _method = SubmissionMethod.text;
        _textController.text = Get.arguments['submitTugas']['text'];
      }
      setState(() {});
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      setState(() {
        fileName = result.files.single.name;
        selectedFile = File(result.files.single.path!);
      });
    }
  }

  void submitTask() {
    if (_method == SubmissionMethod.file) {
      if (fileName != null) {
        if (Get.arguments['submitTugas'] != null) {
          submitTugasC.updateTugas(
            id: Get.arguments['submitTugas']['id'],
            file: selectedFile,
            text: _textController.text,
          );
        } else {
          submitTugasC.postTugas(
            tugasId: Get.arguments['id'].toString(),
            text: _textController.text,
            file: selectedFile,
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Silakan tambahkan file terlebih dahulu")),
        );
      }
    } else {
      if (_textController.text.trim().isNotEmpty) {
        if (Get.arguments['submitTugas'] != null) {
          submitTugasC.updateTugas(
            id: Get.arguments['submitTugas']['id'],
            file: selectedFile,
            text: _textController.text,
          );
        } else {
          submitTugasC.postTugas(
            tugasId: Get.arguments['id'].toString(),
            text: _textController.text,
            file: selectedFile,
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Silakan tulis tugas terlebih dahulu")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengumpulan Tugas"),
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
                    "Soal :",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
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
            const SizedBox(height: 15),
            const MyText(
                text: "Pilih Tipe Pengumpulan Tugas :",
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w600),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300,
                    ),
                    child: RadioListTile<SubmissionMethod>(
                      title: const MyText(
                          text: "Kirim File",
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                      value: SubmissionMethod.file,
                      groupValue: _method,
                      onChanged: (value) {
                        setState(() {
                          _method = value!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300,
                    ),
                    child: RadioListTile<SubmissionMethod>(
                      title: const MyText(
                          text: "Tulis Tugas",
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                      value: SubmissionMethod.text,
                      groupValue: _method,
                      onChanged: (value) {
                        setState(() {
                          _method = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_method == SubmissionMethod.file)
              GestureDetector(
                onTap: pickFile,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C9A8B),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.add, size: 30, color: Colors.black),
                      const SizedBox(height: 8),
                      Text(
                        fileName ?? "Tambah File",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              TextField(
                controller: _textController,
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: "Tulis tugas di sini...",
                  filled: true,
                  fillColor: const Color(0xFFE0F2F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            if (Get.arguments['tipe_tugas'] == "selesai" &&
                Get.arguments['submitTugas']['text'] == null)
              InkWell(
                onTap: () {
                  _launchUrl(
                      "${ApiConstants.baseUrl}/storage/${Get.arguments['submitTugas']['file']}");
                },
                child: Column(
                  children: [
                    const SizedBox(height: 10),
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
            const SizedBox(height: 20),
            Obx(() {
              return SizedBox(
                width: Get.width,
                child: ElevatedButton(
                  onPressed: submitTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF57E389),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 16),
                  ),
                  child: submitTugasC.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text(
                          "SIMPAN TUGAS",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
