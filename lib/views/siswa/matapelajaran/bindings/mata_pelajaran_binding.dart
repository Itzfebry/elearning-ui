import 'package:get/get.dart';
import 'package:ui/views/siswa/matapelajaran/controllers/mata_pelajaran_controller.dart';

class MataPelajaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MataPelajaranController>(() => MataPelajaranController());
  }
}
