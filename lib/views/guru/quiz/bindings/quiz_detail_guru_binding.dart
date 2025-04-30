import 'package:get/get.dart';
import 'package:ui/views/guru/quiz/controllers/quiz_detail_guru_controller.dart';

class QuizDetailGuruBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizDetailGuruController>(() => QuizDetailGuruController());
  }
}
