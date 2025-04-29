import 'package:get/get.dart';
import 'package:ui/views/siswa/quiz/controllers/quiz_controller.dart';

class QuizRankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizController>(() => QuizController());
  }
}
