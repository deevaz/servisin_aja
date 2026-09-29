import 'package:get/get.dart';
import 'workshop_rating_controller.dart';

class WorkshopRatingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkshopRatingController>(() => WorkshopRatingController());
  }
}
