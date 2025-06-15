import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:ui/models/quiz_mode.dart';

class QuizController extends GetxController {
  var isLoading = false.obs;
  QuizModel? quizM;
  var isEmptyData = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Reset data when controller is initialized
    resetData();
    // Delay to ensure arguments are available
    Future.delayed(const Duration(milliseconds: 100), () {
      getQuiz();
    });
  }

  void resetData() {
    quizM = null;
    isEmptyData.value = true;
    isLoading.value = false;
  }

  Future<void> getQuiz() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    log("Get.arguments: ${Get.arguments.toString()}");

    // Check if arguments are available
    if (Get.arguments == null || !Get.arguments.containsKey('id')) {
      log("Arguments not available or missing 'id'");
      isEmptyData.value = true;
      return;
    }

    if (token == null) {
      throw Exception("Token not found");
    }
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      isLoading(true);
      final url =
          "${ApiConstants.quizEnpoint}?matapelajaran_id=${Get.arguments['id'].toString()}";
      log("Requesting URL: $url");

      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      log("Response status: ${response.statusCode}");
      log("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        log("Parsed JSON: $json");

        try {
          quizM = QuizModel.fromJson(json);
          log("Quiz model created successfully");
          log("Quiz data length: ${quizM?.data.length ?? 0}");

          if (quizM!.data.isEmpty) {
            isEmptyData(true);
            log("Quiz data is empty");
          } else {
            isEmptyData(false);
            log("Quiz data has ${quizM!.data.length} items");
          }
        } catch (parseError) {
          log("Error parsing QuizModel: $parseError");
          // Fallback: try to create model without waktu field
          isEmptyData(true);
        }
      } else {
        log("Terjadi kesalahan get data: ${response.statusCode}");
        log("Error response: ${response.body}");
        isEmptyData(true);
      }
    } catch (e) {
      log("Error get quiz: $e");
      isEmptyData(true);
    } finally {
      isLoading(false);
    }
  }
}
