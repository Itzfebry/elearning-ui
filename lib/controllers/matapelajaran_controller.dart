import 'package:get/get.dart';
import 'package:ui/models/matapelajarans.dart';
import 'package:ui/services/matapelajarans.dart';

class MataPelajaranController extends GetxController {
  final MataPelajaranService _service = Get.find<MataPelajaranService>();

  var mataPelajaranList = <MataPelajaran>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchMataPelajaran();
    super.onInit();
  }

  // Ambil semua mata pelajaran
  void fetchMataPelajaran() async {
    try {
      isLoading(true);
      var data = await _service.getAllMataPelajaran();
      mataPelajaranList.assignAll(data);
    } catch (e) {
      Get.snackbar("Error", "Gagal mengambil data");
    } finally {
      isLoading(false);
    }
  }

  // Tambah mata pelajaran
  Future<void> addMataPelajaran(MataPelajaran mataPelajaran) async {
    try {
      await _service.createMataPelajaran(mataPelajaran);
      fetchMataPelajaran(); // Refresh data setelah menambah
    } catch (e) {
      Get.snackbar("Error", "Gagal menambahkan mata pelajaran");
    }
  }

  // Update mata pelajaran
  Future<void> updateMataPelajaran(String id, MataPelajaran mataPelajaran) async {
    try {
      await _service.updateMataPelajaran(id, mataPelajaran);
      fetchMataPelajaran(); // Refresh data setelah update
    } catch (e) {
      Get.snackbar("Error", "Gagal memperbarui mata pelajaran");
    }
  }

  // Hapus mata pelajaran
  Future<void> deleteMataPelajaran(String id) async {
    try {
      await _service.deleteMataPelajaran(id);
      fetchMataPelajaran(); // Refresh data setelah hapus
    } catch (e) {
      Get.snackbar("Error", "Gagal menghapus mata pelajaran");
    }
  }
}
