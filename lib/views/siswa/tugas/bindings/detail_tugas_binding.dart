import 'package:get/get.dart';
import 'package:ui/views/siswa/tugas/controllers/tugas_controller.dart';

class DetailTugasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TugasController>(() => TugasController());
  }
}
