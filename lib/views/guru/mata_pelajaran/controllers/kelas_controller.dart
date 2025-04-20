import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:ui/constans/api_constans.dart';
import 'package:ui/models/kelas_model.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/mata_pelajaran_guru_controller.dart';

class KelasController extends GetxController {
  var isLoading = false.obs;
  var selectedKelas = Rxn<String>();
  KelasModel? kelasM;

  @override
  void onInit() {
    super.onInit();
    getKelas();

    // fetch matpel tiap kali kelas berubah
    ever(selectedKelas, (kelas) {
      if (kelas != null) {
        final matpelGuruC = Get.find<MataPelajaranGuruController>();
        matpelGuruC.getMatPel(kelas: kelas);
      }
    });
  }

  Future<void> getKelas() async {
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
        Uri.parse(ApiConstants.kelasEnpoint),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        kelasM = KelasModel.fromJson(json);

        // Set nilai pertama ke selectedKelas jika belum ada
        if (kelasM != null && kelasM!.data.isNotEmpty) {
          selectedKelas.value = kelasM!.data[0].nama;
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
