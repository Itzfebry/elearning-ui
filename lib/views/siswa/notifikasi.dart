import 'package:flutter/material.dart';
import 'package:ui/widgets/my_text.dart';

class NotifSiswa extends StatelessWidget {
  const NotifSiswa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifikasi")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            cards(type: "quiz"),
            cards(type: "materi"),
            cards(type: "tugas"),
          ],
        ),
      ),
    );
  }

  Container cards({required String type}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFBBDBD0),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: type == "quiz"
              ? const Color(0xFFFD8E8E)
              : type == "materi"
                  ? const Color(0xFF19B91E)
                  : const Color(0xFFDDFD8E),
        ),
        title: const MyText(
            text: "[Quiz Baru]",
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w900),
        subtitle: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
                text: '"Quiz Matematika ditambahkan"',
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w600),
            MyText(
                text: '20 Menit Lalu',
                fontSize: 11,
                color: Colors.black,
                fontWeight: FontWeight.w500),
          ],
        ),
      ),
    );
  }
}
