import 'package:get/get.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/kelas_controller.dart';
import 'package:ui/views/guru/mata_pelajaran/controllers/tahun_ajaran_controller.dart';
import 'package:ui/views/guru/tugas/controllers/tugas_detail_guru_controller.dart';

class TugasDetailGuruBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KelasController>(() => KelasController());
    Get.lazyPut<TahunAjaranController>(() => TahunAjaranController());
    Get.lazyPut<TugasDetailGuruController>(() => TugasDetailGuruController());
  }
}
