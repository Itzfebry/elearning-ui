import 'package:get/get.dart';
import 'package:ui/views/guru/tugas/controllers/detail_submit_tugas_siswa_controller.dart';

class DetailSubmitTugasSiswaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailSubmitTugasSiswaController>(
        () => DetailSubmitTugasSiswaController());
  }
}
