import 'package:get/get.dart';
import 'package:ui/views/siswa/tugas/controllers/submit_tugas_controller.dart';

class SubmitTugasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubmitTugasController>(() => SubmitTugasController());
  }
}
