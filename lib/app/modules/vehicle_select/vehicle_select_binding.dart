import 'package:get/get.dart';
import 'vehicle_select_controller.dart';

class VehicleSelectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehicleSelectController>(() => VehicleSelectController());
  }
}
