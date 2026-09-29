import 'package:get/get.dart';
import 'service_config_controller.dart';

class ServiceConfigBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceConfigController>(() => ServiceConfigController());
  }
}
