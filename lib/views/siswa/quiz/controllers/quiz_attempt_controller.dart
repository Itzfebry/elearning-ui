import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:ui/widgets/my_snackbar.dart';

class QuizAttemptController extends GetxController {
  var isLoadingAttempt = false.obs;

  @override
  void onInit() {
    super.onInit();
    var quizId = Get.arguments['quiz_id'];
    postQuizAttemptStart(quizId);
  }

  Future<void> postQuizAttemptStart(var quizId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final nisn = prefs.getString('nisn');

    if (token == null) {
      throw Exception("Token not found");
    }
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      isLoadingAttempt(true);
      Map body = {
        'quiz_id': quizId,
        'nisn': nisn,
      };
      final response = await http.post(
        Uri.parse(ApiConstants.quizAttemptStartEnpoint),
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        snackbarSuccess(json['message'] ?? "Quiz");
      } else {
        log("Terjadi kesalahan get data: ${response.statusCode}");
      }
    } catch (e) {
      log("Error get matpel simple: $e");
    } finally {
      isLoadingAttempt(false);
    }
  }
}
