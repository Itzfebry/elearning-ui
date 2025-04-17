import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:ui/models/mata_pelajaran_simple_model.dart';

class MataPelajaranSimpleController extends GetxController {
  var isLoading = false.obs;
  MataPelajaranSimpleModel? mataPelajaranSimpleM;
  var isEmptyData = true.obs;

  @override
  void onInit() {
    super.onInit();
    getMatPelSimple();
  }

  Future<void> getMatPelSimple() async {
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
        Uri.parse(ApiConstants.mataPelajaranSimpleEnpoint),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        mataPelajaranSimpleM = MataPelajaranSimpleModel.fromJson(json);
        if (mataPelajaranSimpleM!.data.isEmpty) {
          isEmptyData(true);
        } else {
          isEmptyData(false);
        }
      } else {
        log("Terjadi kesalahan get data: ${response.statusCode}");
      }
    } catch (e) {
      log("Error get matpel simple: $e");
    } finally {
      isLoading(false);
    }
  }
}
