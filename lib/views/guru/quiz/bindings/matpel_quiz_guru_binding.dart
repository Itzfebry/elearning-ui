import 'package:get/get.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/kelas_controller.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/mata_pelajaran_guru_controller.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/tahun_ajaran_controller.dart';

class MatpelQuizGuruBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KelasController>(() => KelasController());
    Get.lazyPut<TahunAjaranController>(() => TahunAjaranController());
    Get.lazyPut<MataPelajaranGuruController>(
      () => MataPelajaranGuruController(),
    );
  }
}
