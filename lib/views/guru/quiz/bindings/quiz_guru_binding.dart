import 'package:get/get.dart';
import 'package:ui/views/guru/quiz/controllers/quiz_guru_controller.dart';

class QuizGuruBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizGuruController>(() => QuizGuruController());
  }
}
