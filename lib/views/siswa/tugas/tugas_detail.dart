import 'package:flutter/material.dart';

class TugasDetail extends StatelessWidget {
  const TugasDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Tugas")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              title: const Text("tugas.judul",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text("tugas.deskripsi"),
              trailing: const Text("Deadline: ugas.deadline"),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => TugasCommit(tugasId: tugas.id),
                //   ),
                // );
              },
            ),
          );
        },
      ),
    );
  }
}
