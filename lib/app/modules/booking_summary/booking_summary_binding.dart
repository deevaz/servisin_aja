import 'package:get/get.dart';
import 'booking_summary_controller.dart';

class BookingSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingSummaryController>(() => BookingSummaryController());
  }
}
