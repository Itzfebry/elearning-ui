import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/siswa/controllers/notifikasi_controller.dart';
import 'package:ui/widgets/my_text.dart';

class NotifSiswa extends StatelessWidget {
  NotifSiswa({super.key});
  final notifC = Get.find<NotifikasiController>();

  aksi(type) {
    switch (type) {
      case "Quiz":
        Get.toNamed(AppRoutes.matpelQuiz)?.then((_) {
          notifC.getNotif();
        });
        break;
      case "Materi":
        Get.toNamed(AppRoutes.kelasmatapelajarans)?.then((_) {
          notifC.getNotif();
        });
        break;
      case "Tugas":
        Get.toNamed(AppRoutes.tugasSiswa)?.then((_) {
          notifC.getNotif();
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Notifikasi"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(() {
          if (notifC.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: notifC.dataNotif.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var data = notifC.dataNotif[index];
              return cards(
                id: data['id'],
                type: data['type'],
                judul: data['judul'],
                isActive: data['is_active'],
                waktu: data['created_at'],
              );
            },
          );
        }),
      ),
    );
  }

  Widget cards({
    required String id,
    required String type,
    required String judul,
    required bool isActive,
    required String waktu,
  }) {
    return InkWell(
      onTap: () {
        notifC.readNotif(id: id);
        aksi(type);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: isActive ? const Color(0xFFBBDBD0) : Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 0,
                blurRadius: 2,
                offset: Offset(0, 2),
              )
            ]),
        child: ListTile(
          leading: CircleAvatar(
            radius: 22,
            backgroundColor: type == "Quiz"
                ? const Color(0xFFFD8E8E)
                : type == "Materi"
                    ? const Color(0xFF19B91E)
                    : const Color(0xFFDDFD8E),
            child: Icon(type == "Quiz"
                ? Icons.quiz_rounded
                : type == "Materi"
                    ? Icons.menu_book_rounded
                    : Icons.assignment_rounded),
          ),
          title: MyText(
              text: "[$type Baru]",
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w900),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                  text: judul,
                  maxLines: 1,
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
              MyText(
                  text: waktu,
                  fontSize: 11,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ],
          ),
        ),
      ),
    );
  }
}
