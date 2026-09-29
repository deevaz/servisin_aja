import 'package:get/get.dart';
import '../../data/models/booking.dart';
import '../../data/repositories/booking_repository.dart';
import '../../routes/app_routes.dart';

class TrackingController extends GetxController {
  final BookingRepository _bookingRepo = Get.find();

  final Rx<Booking?> booking = Rx<Booking?>(null);
  final RxInt selectedVehicleIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments ?? {};
    if (args['booking'] != null) {
      booking.value = args['booking'];
    } else if (args['bookingId'] != null) {
      booking.value = _bookingRepo.getBookingById(args['bookingId']);
    } else if (_bookingRepo.bookings.isNotEmpty) {
      booking.value = _bookingRepo.bookings.first;
    }
  }

  void selectVehicleTab(int index) {
    selectedVehicleIndex.value = index;
  }

  void goToInvoice() {
    if (booking.value != null) {
      Get.toNamed(
        Routes.invoiceDetail,
        arguments: {'booking': booking.value},
      );
    }
  }

  void goToRating() {
    if (booking.value != null) {
      Get.toNamed(
        Routes.workshopRating,
        arguments: {'booking': booking.value},
      );
    }
  }
}
