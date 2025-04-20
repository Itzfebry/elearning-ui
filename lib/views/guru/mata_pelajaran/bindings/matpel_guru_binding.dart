import 'package:get/get.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/mata_pelajaran_guru_controller.dart';

class MatpelGuruBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MataPelajaranGuruController>(
      () => MataPelajaranGuruController(),
    );
  }
}
