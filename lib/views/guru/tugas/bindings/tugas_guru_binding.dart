import 'package:get/get.dart';
import 'package:ui/views/siswa/matapelajaran/controllers/mata_pelajaran_simple_controller.dart';

class TugasGuruBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MataPelajaranSimpleController>(
        () => MataPelajaranSimpleController());
  }
}
