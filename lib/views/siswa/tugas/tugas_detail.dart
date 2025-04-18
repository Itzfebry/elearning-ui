import 'package:flutter/material.dart';
import 'package:ui/widgets/my_text.dart';

class TugasDetail extends StatefulWidget {
  const TugasDetail({super.key});

  @override
  State<TugasDetail> createState() => _TugasDetailState();
}

class _TugasDetailState extends State<TugasDetail> {
  var isActive = "belum";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Tugas")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: buttonTab(),
          ),
          tugasBelum(),
        ],
      ),
    );
  }

  Row buttonTab() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isActive = "belum";
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            decoration: BoxDecoration(
              color: isActive == "belum"
                  ? const Color(0xFF75FF33)
                  : const Color(0xFFD2E5C9),
              borderRadius: BorderRadius.circular(32),
            ),
            child: const Text(
              "Belum",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isActive = "selesai";
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            decoration: BoxDecoration(
              color: isActive == "selesai"
                  ? const Color(0xFF75FF33)
                  : const Color(0xFFD2E5C9),
              borderRadius: BorderRadius.circular(32),
            ),
            child: const Text(
              "Selesai",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  ListView tugasBelum() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      itemCount: 1,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            title: const Text(
              "tugas.judul",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            subtitle: const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    text: "12-01-2025",
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  MyText(
                    text: "Tenggat : 12-01-2025",
                    fontSize: 14,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  )
                ],
              ),
            ),
            onTap: () {},
          ),
        );
      },
    );
  }
}
