import 'package:get/get.dart';
import '../../core/utils/dialog_util.dart';

class MainController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void onNavTap(int index) {
    if (index == 2) {
      DialogUtil.showUnderDevelopment(featureName: 'Halaman Profil');
      return;
    }
    currentIndex.value = index;
  }
}
