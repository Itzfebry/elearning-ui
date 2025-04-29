import 'package:get/get.dart';
import 'package:ui/views/siswa/quiz/controllers/quiz_finish_controller.dart';

class QuizFinishBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizFinishController>(() => QuizFinishController());
  }
}
