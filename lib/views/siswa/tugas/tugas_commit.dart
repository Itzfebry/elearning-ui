import 'package:flutter/material.dart';
import 'package:ui/services/tugas_siswas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TugasCommit extends StatefulWidget {
  final String tugasId;

  const TugasCommit({super.key, required this.tugasId});

  @override
  _TugasCommitState createState() => _TugasCommitState();
}

class _TugasCommitState extends State<TugasCommit> {
  final TextEditingController komentarController = TextEditingController();
  String fileUrl = "";

  Future<void> submitTugas() async {
    if (fileUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Silakan unggah file terlebih dahulu")),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/tugas_siswas'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'tugas_guru_id': widget.tugasId,
          'siswa_id': "SISWA_ID", // Gantilah dengan ID siswa yang sesuai
          'file_url': fileUrl,
          'komentar': komentarController.text,
          'status': 'submitted',
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Tugas berhasil dikumpulkan!")),
        );
        Navigator.pop(context);
      } else {
        throw Exception("Gagal mengirim tugas");
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi kesalahan saat mengirim tugas")),
      );
    }
  }

  Future<void> pickFile() async {
    // **Implementasi pemilihan file di sini**
    setState(() {
      fileUrl = "https://example.com/sample.pdf"; // Simulasi URL file yang diunggah
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kumpulkan Tugas")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Unggah Tugas", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: pickFile,
              child: const Text("Pilih File"),
            ),
            if (fileUrl.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text("File terunggah: $fileUrl"),
              ),
            const SizedBox(height: 20),
            TextField(
              controller: komentarController,
              decoration: const InputDecoration(labelText: "Tambahkan Komentar"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitTugas,
              child: const Text("Kirim Tugas"),
            ),
          ],
        ),
      ),
    );
  }
}
