import 'package:get/get.dart';
import 'package:ui/views/siswa/ranking/controllers/ranking_controller.dart';

class RankingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RankingController>(() => RankingController());
  }
}
