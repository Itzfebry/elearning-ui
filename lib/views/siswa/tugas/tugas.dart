import 'package:flutter/material.dart';
import 'package:ui/views/siswa/tugas/tugas_detail.dart'; // Import halaman detail tugas

class Tugas extends StatefulWidget {
  const Tugas({super.key});

  @override
  _TugasState createState() => _TugasState();
}

class _TugasState extends State<Tugas> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tugas")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tugas',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFBBDBD0),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.fromLTRB(23, 19, 23, 40),
                        child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return const TaskItem(
                              title: "matapelajaran.name",
                              mataPelajaranId:
                                  "matapelajaran.id", // Kirim ID ke halaman detail
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final String title;
  final String mataPelajaranId; // ID mata pelajaran

  const TaskItem(
      {super.key, required this.title, required this.mataPelajaranId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail tugas
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => TugasDetail(mataPelajaranId: mataPelajaranId),
        //   ),
        // );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 40),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF67DEAC),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}
