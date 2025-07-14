import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntp/ntp.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/siswa/tugas/controllers/tugas_controller.dart';
import 'package:ui/widgets/my_date_format.dart';
import 'package:ui/widgets/my_snackbar.dart';
import 'package:ui/widgets/my_text.dart';
import 'dart:developer';

class TugasDetail extends StatefulWidget {
  const TugasDetail({super.key});

  @override
  State<TugasDetail> createState() => _TugasDetailState();
}

class _TugasDetailState extends State<TugasDetail> {
  TugasController tugasC = Get.find<TugasController>();
  var isActive = "belum";
  DateTime? dateNow;

  @override
  void initState() {
    super.initState();
    log("TugasDetail initState called");
    log("Arguments received: " + Get.arguments.toString());
    log("Arguments type: " + Get.arguments.runtimeType.toString());
    dynamic arg = Get.arguments;
    String? tugasId;
    if (arg is String) {
      tugasId = arg;
    } else if (arg is Map && arg['id'] != null) {
      tugasId = arg['id'].toString();
    } else if (arg is int) {
      tugasId = arg.toString();
    }
    print(
        '[DETAIL] ID diterima di detail: $tugasId ( [36m${tugasId.runtimeType} [0m)');
    if (tugasId != null) {
      tugasC.getTugas(id: tugasId, type: "belum");
    }
  }

  Future<void> getCurrentTime() async {
    DateTime now = await NTP.now();
    dateNow = DateTime(now.year, now.month, now.day);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.assignment,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "Detail Tugas",
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF6366F1),
                Color(0xFF8B5CF6),
                Color(0xFFEC4899),
              ],
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: buttonTab(),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  child: Column(
                    children: [
                      if (isActive == "belum") Expanded(child: tugasBelum()),
                      if (isActive == "selesai")
                        Expanded(child: tugasSelesai()),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonTab() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                log("Tab 'Belum' tapped");
                setState(() {
                  isActive = "belum";
                });
                log("Calling getTugas with id: ${Get.arguments}, type: belum");
                tugasC.getTugas(id: Get.arguments, type: "belum");
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  gradient: isActive == "belum"
                      ? const LinearGradient(
                          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isActive == "belum" ? null : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.pending_actions,
                      color: isActive == "belum"
                          ? Colors.white
                          : Colors.grey.shade600,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "Belum",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isActive == "belum"
                            ? Colors.white
                            : Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                log("Tab 'Selesai' tapped");
                setState(() {
                  isActive = "selesai";
                });
                log("Calling getTugas with id: ${Get.arguments}, type: selesai");
                tugasC.getTugas(id: Get.arguments, type: "selesai");
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  gradient: isActive == "selesai"
                      ? const LinearGradient(
                          colors: [Color(0xFF10B981), Color(0xFF059669)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isActive == "selesai" ? null : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: isActive == "selesai"
                          ? Colors.white
                          : Colors.grey.shade600,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "Selesai",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isActive == "selesai"
                            ? Colors.white
                            : Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tugasBelum() {
    return Obx(
      () {
        log("tugasBelum widget rebuilt");
        log("isLoading: ${tugasC.isLoading.value}");
        log("tugasM: ${tugasC.tugasM}");
        log("data length: ${tugasC.tugasM?.data.length ?? 0}");
        log("data isEmpty: ${tugasC.tugasM?.data.isEmpty ?? true}");

        if (tugasC.isLoading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF6366F1),
                    ),
                    strokeWidth: 3,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Memuat tugas...",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          );
        } else if (tugasC.tugasM?.data.isEmpty ?? true) {
          log("Showing empty data widget");
          return emptyData();
        }
        log("Showing data list with ${tugasC.tugasM?.data.length ?? 0} items");
        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: tugasC.tugasM?.data.length ?? 0,
          itemBuilder: (context, index) {
            var data = tugasC.tugasM?.data[index];
            return data?.submitTugas != null
                ? const SizedBox.shrink()
                : Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.shade50,
                          Colors.blue.shade100,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () async {
                          var tenggat = data!.tenggat;
                          int year = int.parse(tenggat.getYear());
                          int month = int.parse(tenggat.getMonthNumber());
                          int day = int.parse(tenggat.getTgl());

                          await getCurrentTime();

                          DateTime batasTanggal = DateTime(year, month, day);

                          if (dateNow!.isAfter(batasTanggal)) {
                            snackbarfailed(
                                "Batas waktu sudah lewat, tidak bisa mengumpulkan tugas.");
                          } else {
                            Get.toNamed(
                              AppRoutes.tugasCommitSiswa,
                              arguments: {
                                "id": data.id,
                                "tipe_tugas": "belum",
                                "title": data.nama,
                                "deskripsi": data.deskripsi,
                                "submitTugas": null
                              },
                            )?.then(
                              (value) {
                                if (value == true) {
                                  tugasC.getTugas(
                                      id: Get.arguments.toString(),
                                      type: "belum");
                                }
                              },
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade500,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Icon(
                                      Icons.assignment,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data!.nama,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          data!.deskripsi
                                                      ?.toString()
                                                      .isNotEmpty ==
                                                  true
                                              ? data!.deskripsi.toString()
                                              : 'Tidak ada deskripsi tugas.',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black54,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        // Hapus created_at dan updated_at untuk tugas belum
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.calendar_today,
                                                    size: 16,
                                                    color: Colors.blue),
                                                const SizedBox(width: 6),
                                                Text(
                                                  'Tanggal dibuat:',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 22.0,
                                                  top: 2,
                                                  bottom: 6),
                                              child: (() {
                                                final t = data.createdAt;
                                                final dt = t is! DateTime
                                                    ? DateTime.parse(
                                                        t.toString())
                                                    : t;
                                                return Text(
                                                  dt.fullDateTime(),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          Colors.blue.shade800,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                );
                                              })(),
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.schedule,
                                                    size: 16,
                                                    color: Colors.red),
                                                const SizedBox(width: 6),
                                                Text(
                                                  'Tenggat tugas:',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 22.0, top: 2),
                                              child: Text(
                                                data.tenggat.fullDateTime(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.red.shade800,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.blue.shade500,
                                    size: 16,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            size: 14,
                                            color: Colors.blue.shade600,
                                          ),
                                          const SizedBox(width: 4),
                                          Flexible(
                                            child: Text(
                                              data.tanggal.fullDateTime(),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.blue.shade600,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade50,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.schedule,
                                            size: 14,
                                            color: Colors.red.shade600,
                                          ),
                                          const SizedBox(width: 4),
                                          Flexible(
                                            child: Text(
                                              data.tenggat.fullDateTime(),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.red.shade600,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
          },
        );
      },
    );
  }

  Widget emptyData() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    isActive == "belum"
                        ? Icons.pending_actions
                        : Icons.check_circle_outline,
                    size: 60,
                    color: const Color(0xFF6366F1),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  isActive == "belum"
                      ? "Tidak Ada Tugas"
                      : "Tidak Ada Tugas Selesai",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isActive == "belum"
                      ? "Belum ada tugas yang perlu dikerjakan"
                      : "Belum ada tugas yang telah selesai dikerjakan",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tugasSelesai() {
    return Obx(
      () {
        log("tugasSelesai widget rebuilt");
        log("isLoading: ${tugasC.isLoading.value}");
        log("tugasM: ${tugasC.tugasM}");
        log("data length: ${tugasC.tugasM?.data.length ?? 0}");
        log("data isEmpty: ${tugasC.tugasM?.data.isEmpty ?? true}");

        if (tugasC.isLoading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF10B981),
                    ),
                    strokeWidth: 3,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Memuat tugas...",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          );
        } else if (tugasC.tugasM?.data.isEmpty ?? true) {
          log("Showing empty data widget");
          return emptyData();
        }
        log("Showing data list with ${tugasC.tugasM?.data.length ?? 0} items");
        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: tugasC.tugasM?.data.length ?? 0,
          itemBuilder: (context, index) {
            var data = tugasC.tugasM?.data[index];
            return data?.submitTugas == null
                ? const SizedBox.shrink()
                : Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.green.shade50,
                          Colors.green.shade100,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () async {
                          Get.toNamed(
                            AppRoutes.tugasCommitSiswa,
                            arguments: {
                              "id": data!.submitTugas!.id,
                              "tipe_tugas": "selesai",
                              "title": data.nama,
                              "deskripsi": data.deskripsi,
                              "submitTugas": {
                                "id": data.submitTugas!.id,
                                "tanggal": data.submitTugas!.tanggal,
                                "nisn": data.submitTugas!.nisn,
                                "tugas_id": data.submitTugas!.tugasId,
                                "text": data.submitTugas?.text,
                                "file": data.submitTugas?.file,
                              }
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade500,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Icon(
                                      Icons.check_circle,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data!.nama,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          data!.deskripsi
                                                      ?.toString()
                                                      .isNotEmpty ==
                                                  true
                                              ? data!.deskripsi.toString()
                                              : 'Tidak ada deskripsi tugas.',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black54,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade100,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            "Sudah Dikerjakan",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.green.shade700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.green.shade500,
                                    size: 16,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today,
                                          size: 16, color: Colors.blue),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Tanggal dibuat:',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 22.0, top: 2, bottom: 6),
                                    child: (() {
                                      final t = data.createdAt;
                                      final dt = t is! DateTime
                                          ? DateTime.parse(t.toString())
                                          : t;
                                      return Text(
                                        dt.fullDateTime(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.blue.shade800,
                                            fontWeight: FontWeight.w600),
                                      );
                                    })(),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.schedule,
                                          size: 16, color: Colors.red),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Tenggat tugas:',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.red,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 22.0, top: 2, bottom: 6),
                                    child: Text(
                                      data.tenggat.fullDateTime(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.red.shade800,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  if (data.submitTugas != null) ...[
                                    Row(
                                      children: [
                                        Icon(Icons.done_all,
                                            size: 16, color: Colors.green),
                                        const SizedBox(width: 6),
                                        Text(
                                          'Waktu submit:',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.green,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 22.0, top: 2, bottom: 6),
                                      child: (() {
                                        final t = data.submitTugas!.createdAt;
                                        final dt = t is! DateTime
                                            ? DateTime.parse(t.toString())
                                            : t;
                                        return Text(
                                          dt.fullDateTime(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.green.shade800,
                                              fontWeight: FontWeight.w600),
                                        );
                                      })(),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.update,
                                            size: 16, color: Colors.orange),
                                        const SizedBox(width: 6),
                                        Text(
                                          'Diperbarui:',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.orange,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 22.0, top: 2),
                                      child: (() {
                                        final t = data.submitTugas!.updatedAt;
                                        final dt = t is! DateTime
                                            ? DateTime.parse(t.toString())
                                            : t;
                                        return Text(
                                          dt.fullDateTime(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.orange.shade800,
                                              fontWeight: FontWeight.w600),
                                        );
                                      })(),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.upload_file,
                                          size: 16,
                                          color: Colors.blue.shade600,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "Dikumpulkan:",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.blue.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 24.0, top: 4),
                                      child: Text(
                                        (() {
                                          final t = data.submitTugas!.updatedAt;
                                          final dt = t is! DateTime
                                              ? DateTime.parse(t.toString())
                                              : t;
                                          return dt.fullDateTime();
                                        })(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue.shade600,
                                        ),
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
          },
        );
      },
    );
  }
}
