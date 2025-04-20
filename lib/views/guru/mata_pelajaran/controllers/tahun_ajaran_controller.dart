import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:ui/constans/api_constans.dart';
import 'package:ui/models/tahun_ajaran.dart';
// import 'package:ui/views/guru/mata_pelajaran/controllers/mata_pelajaran_guru_controller.dart';

class TahunAjaranController extends GetxController {
  var isLoading = false.obs;
  var selectedTahun = Rxn<String>();
  TahunAjaranModel? tahunAjaranM;

  @override
  void onInit() {
    super.onInit();
    getTahunAjaran();

    // // fetch matpel tiap kali kelas berubah
    // ever(selectedTahun, (kelas) {
    //   if (kelas != null) {
    //     final matpelGuruC = Get.find<MataPelajaranGuruController>();
    //     matpelGuruC.getMatPel(kelas: kelas);
    //   }
    // });
  }

  Future<void> getTahunAjaran() async {
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
      isLoading(true);
      final response = await http.get(
        Uri.parse(ApiConstants.tahunAjaranEnpoint),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        tahunAjaranM = TahunAjaranModel.fromJson(json);

        // Set nilai pertama ke selectedTahun jika belum ada
        if (tahunAjaranM != null && tahunAjaranM!.data.isNotEmpty) {
          selectedTahun.value = tahunAjaranM!.data[0].tahun;
        }
      } else {
        log("Terjadi kesalahan get data: ${response.statusCode}");
      }
    } catch (e) {
      log("Error getMe: $e");
    } finally {
      isLoading(false);
    }
  }
}
