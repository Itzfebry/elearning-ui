import 'package:get/get.dart';
import 'package:ui/views/siswa/controllers/notifikasi_controller.dart';

class NotifikasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotifikasiController>(() => NotifikasiController());
  }
}
