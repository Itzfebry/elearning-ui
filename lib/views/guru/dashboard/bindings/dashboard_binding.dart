import 'package:get/get.dart';
import 'package:ui/views/siswa/controllers/siswa_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SiswaController>(() => SiswaController());
  }
}
