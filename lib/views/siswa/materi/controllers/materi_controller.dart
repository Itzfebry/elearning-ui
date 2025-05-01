import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:ui/models/materi_buku_model.dart';
import 'package:ui/models/materi_video_model.dart';
import 'package:http/http.dart' as http;
import 'package:ui/widgets/my_snackbar.dart';

class MateriController extends GetxController {
  var isMateriLoaded = false.obs;
  var isVideoLoaded = false.obs;
  MateriBukuModel? materiBuku;
  MateriVideoModel? materiVideo;
  var isLoadingBuku = false.obs;
  var isLoadingVideo = false.obs;

  Future<void> getMateriBuku({required idMatpel, required semester}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception("Token not found");
    }
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    log(semester.toString());

    try {
      isLoadingBuku(true);
      final response = await http.get(
        Uri.parse(
            "${ApiConstants.getMateriEnpoint}?id_matpel=$idMatpel&semester=$semester&type=buku"),
        headers: headers,
      );

      final json = jsonDecode(response.body);
      log(json.toString());
      if (response.statusCode == 200) {
        materiBuku = MateriBukuModel.fromJson(json);
        isMateriLoaded(true);
      } else {
        log("terjadi kesalahan get data materi Buku : ${response.statusCode}");
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoadingBuku(false);
    }
  }

  Future<void> getMateriVideo({required idMatpel, required semester}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception("Token not found");
    }
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      isLoadingVideo(true);
      final response = await http.get(
        Uri.parse(
            "${ApiConstants.getMateriEnpoint}?id_matpel=$idMatpel&semester=$semester&type=video"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        materiVideo = MateriVideoModel.fromJson(json);
        isVideoLoaded(true);
      } else {
        log("terjadi kesalahan get data materi Video : ${response.statusCode}");
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoadingVideo(false);
    }
  }

  Future<void> downloadPdfWithHttp(
      String filePath, String? judul, String? smt) async {
    try {
      // premision
      if (Platform.isAndroid) {
        var status = await Permission.manageExternalStorage.request();
        if (!status.isGranted) {
          throw Exception("Izin ditolak");
        }
      }

      final fullUrl = "${ApiConstants.baseUrl}/storage/$filePath";
      log(fullUrl.toString());

      final response = await http.get(Uri.parse(fullUrl));
      if (response.statusCode == 200) {
        // Simpan ke folder Downloads
        final downloadsDir = Directory('/storage/emulated/0/Download');
        if (!await downloadsDir.exists()) {
          await downloadsDir.create(recursive: true);
        }

        final filename = judul != null
            ? "${judul}_semester_$smt.pdf"
            : filePath.split('/').last;
        final file = File('${downloadsDir.path}/$filename');
        await file.writeAsBytes(response.bodyBytes);
        log("File disimpan di: ${file.path}");
        snackbarAlert("Download...", "File berhasil disimpan sebagai $filename",
            const Color(0xFF3C4D55));
      } else {
        log("Gagal download: ${response.statusCode}");
      }
    } catch (e) {
      log("Terjadi error: $e");
    }
  }
}
