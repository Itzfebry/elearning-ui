import 'package:get/get.dart';
import 'package:ui/views/siswa/quiz/controllers/quiz_controller.dart';

class QuizBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<QuizController>(QuizController());
  }
}
