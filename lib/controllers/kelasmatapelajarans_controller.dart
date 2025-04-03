import 'package:get/get.dart';
import 'package:ui/models/kelasmatapelajarans.dart';
import 'package:ui/services/kelas_matapelajarans.dart';

class KelasMataPelajaranController extends GetxController {
  var isLoading = false.obs;
  var kelasMataPelajaranList = <KelasMataPelajaran>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchKelasMataPelajaran();
  }

  Future<void> fetchKelasMataPelajaran() async {
    try {
      isLoading.value = true;
      var data = await KelasMataPelajaranService.getKelasMataPelajaran();
      kelasMataPelajaranList.assignAll(data);
    } finally {
      isLoading.value = false;
    }
  }
}
