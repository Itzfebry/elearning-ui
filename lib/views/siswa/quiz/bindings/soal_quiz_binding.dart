import 'package:get/get.dart';
import 'package:ui/views/siswa/quiz/controllers/quiz_attempt_controller.dart';

class SoalQuizBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizAttemptController>(() => QuizAttemptController());
  }
}
