import 'package:get/get.dart';
import 'package:ui/controllers/kelasmatapelajarans_controller.dart';

class KelasMataPelajaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KelasMataPelajaranController>(() => KelasMataPelajaranController());
  }
}
