import 'package:get/get.dart';
import '../home/home_controller.dart';
import '../booking_history/booking_history_controller.dart';
import 'main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => BookingHistoryController());
  }
}
