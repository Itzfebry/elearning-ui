import 'package:get/get.dart';
import 'package:ui/views/siswa/controllers/notifikasi_count_controller.dart';
import 'package:ui/views/siswa/controllers/siswa_controller.dart';

class SiswaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SiswaController>(() => SiswaController());
    Get.lazyPut<NotifikasiCountController>(() => NotifikasiCountController());
  }
}
