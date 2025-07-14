import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:http/http.dart' as http;

class RankingController extends GetxController {
  var isLoading = false.obs;
  var leaderboard = [].obs;
  var myScore = ''.obs;
  var myScoreTime = ''.obs;
  var isEmpty = true.obs;

  @override
  void onInit() {
    super.onInit();
    var quizId = Get.arguments['quiz_id'];
    getLeaderboard(quizId);
    getMyScore(quizId);
  }

  Future<void> getLeaderboard(String quizId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrlApi}/quiz/$quizId/ranking'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['success'] == true && json['ranking'] is List) {
          leaderboard.value = json['ranking'];
          isEmpty.value = leaderboard.isEmpty;
        } else {
          leaderboard.value = [];
          isEmpty.value = true;
        }
      } else {
        leaderboard.value = [];
        isEmpty.value = true;
      }
    } catch (e) {
      leaderboard.value = [];
      isEmpty.value = true;
    } finally {
      isLoading(false);
    }
  }

  Future<void> getMyScore(String quizId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrlApi}/quiz/$quizId/skor-saya'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['success'] == true) {
          myScore.value = json['skor'].toString();
          myScoreTime.value = json['waktu_selesai'] ?? '';
        } else {
          myScore.value = '-';
          myScoreTime.value = '';
        }
      } else {
        myScore.value = '-';
        myScoreTime.value = '';
      }
    } catch (e) {
      myScore.value = '-';
      myScoreTime.value = '';
    }
  }

  Future<void> refreshData() async {
    var quizId = Get.arguments['quiz_id'];
    await getLeaderboard(quizId);
    await getMyScore(quizId);
  }
}
