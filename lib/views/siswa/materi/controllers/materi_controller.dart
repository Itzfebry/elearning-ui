import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:ui/models/materi_buku_model.dart';
import 'package:ui/models/materi_video_model.dart';
import 'package:http/http.dart' as http;

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
}
