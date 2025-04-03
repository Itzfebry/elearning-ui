import 'package:flutter/material.dart';
import 'package:ui/models/tugas_gurus.dart';
import 'package:ui/services/tugas_gurus.dart';
import 'package:ui/views/siswa/tugas/tugas_commit.dart';

class TugasDetail extends StatefulWidget {
  final String mataPelajaranId;

  const TugasDetail({super.key, required this.mataPelajaranId});

  @override
  _TugasDetailState createState() => _TugasDetailState();
}

class _TugasDetailState extends State<TugasDetail> {
  final TugasGuruService _service = TugasGuruService();
  List<TugasGuru> tugasList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
      print("Mata Pelajaran ID yang diterima: ${widget.mataPelajaranId}"); // Debugging
    fetchTugas();
  }

  Future<void> fetchTugas() async {
  try {
    print("🟢 Fetching tugas untuk mataPelajaranId: ${widget.mataPelajaranId}");
    List<TugasGuru> data = await _service.getTugasByMataPelajaran(widget.mataPelajaranId);
    print("🟡 Data yang diterima dari API: $data");

    setState(() {
      tugasList = data;
      isLoading = false;
    });
  } catch (e) {
    print("🔴 Error saat mengambil tugas: $e");
    setState(() {
      isLoading = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Tugas")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tugasList.length,
              itemBuilder: (context, index) {
                final tugas = tugasList[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    title: Text(tugas.judul, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(tugas.deskripsi),
                    trailing: Text("Deadline: ${tugas.deadline}"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TugasCommit(tugasId: tugas.id),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
