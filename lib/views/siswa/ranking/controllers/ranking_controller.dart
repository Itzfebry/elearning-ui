import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:http/http.dart' as http;

class RankingController extends GetxController {
  var isLoading = false.obs;
  var skorMe = "".obs;
  var data = {}.obs;
  var isEmpty = true.obs;

  @override
  void onInit() {
    super.onInit();
    var quizId = Get.arguments['quiz_id'];
    getQuiz(quizId);
  }

  Future<void> getQuiz(quizId) async {
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
        Uri.parse("${ApiConstants.quizTopFiveEnpoint}?quiz_id=$quizId"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        skorMe.value = json['skor_me']['skor'];

        // Mengurutkan data berdasarkan skor tertinggi
        if (json['data'] != null && json['data'] is List) {
          List<dynamic> sortedData = List.from(json['data']);

          // Log data sebelum pengurutan
          log("Data sebelum pengurutan:");
          for (int i = 0; i < sortedData.length; i++) {
            log("${i + 1}. ${sortedData[i]['siswa']['nama']} - Skor: ${sortedData[i]['skor']}");
          }

          sortedData.sort((a, b) {
            int skorA = int.tryParse(a['skor'].toString()) ?? 0;
            int skorB = int.tryParse(b['skor'].toString()) ?? 0;
            return skorB.compareTo(skorA); // Urutkan dari tertinggi ke terendah
          });

          // Log data setelah pengurutan
          log("Data setelah pengurutan (skor tertinggi):");
          for (int i = 0; i < sortedData.length; i++) {
            log("${i + 1}. ${sortedData[i]['siswa']['nama']} - Skor: ${sortedData[i]['skor']}");
          }

          json['data'] = sortedData;
        }

        data.value = json;
        if (json['data'].length == 0) {
          isEmpty(true);
        } else {
          isEmpty(false);
        }

        log("Data ranking berhasil diurutkan berdasarkan skor tertinggi");
      } else {
        log("Terjadi kesalahan get data: ${response.statusCode}");
      }
    } catch (e) {
      log("Error get quiz simple: $e");
    } finally {
      isLoading(false);
    }
  }

  // Method untuk refresh data
  Future<void> refreshData() async {
    var quizId = Get.arguments['quiz_id'];
    await getQuiz(quizId);
  }
}
