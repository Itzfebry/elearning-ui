import 'package:get/get.dart';
import 'package:ui/views/siswa/controllers/ubah_password_controller.dart';

class UbahPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UbahPasswordController>(() => UbahPasswordController());
  }
}
