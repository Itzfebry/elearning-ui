import 'package:flutter/material.dart';
import 'package:ui/models/materis.dart';
import 'package:ui/services/materis.dart';

class MaterisSiswaPage extends StatefulWidget {
  final String mataPelajaranId;

  const MaterisSiswaPage({super.key, required this.mataPelajaranId});

  @override
  _MaterisSiswaPageState createState() => _MaterisSiswaPageState();
}

class _MaterisSiswaPageState extends State<MaterisSiswaPage> {
  final MateriService _service = MateriService();
  List<Materi> materiList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMateri();
  }

  Future<void> fetchMateri() async {
    try {
      List<Materi> data = await _service.getMateriByMataPelajaran(widget.mataPelajaranId);
      setState(() {
        materiList = data;
        isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Materi"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: materiList.length,
              itemBuilder: (context, index) {
                Materi materi = materiList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 4,
                  child: ListTile(
                    title: Text(materi.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(materi.description ?? "Tidak ada deskripsi"),
                    trailing: const Icon(Icons.file_download, color: Colors.blue),
                    onTap: () {
                      // Buka file materi (bisa menggunakan openUrl atau PDF viewer)
                    },
                  ),
                );
              },
            ),
    );
  }
}
