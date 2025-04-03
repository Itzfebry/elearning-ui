import 'package:get/get.dart';
import 'package:ui/controllers/matapelajaran_controller.dart';
import 'package:ui/services/matapelajarans.dart';

class MataPelajaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MataPelajaranService>(MataPelajaranService()); // <-- Pakai Get.put
    Get.put<MataPelajaranController>(MataPelajaranController()); // <-- Pakai Get.put
  }
}

