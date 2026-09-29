import 'package:get/get.dart';
import '../../data/models/booking.dart';
import '../../data/repositories/booking_repository.dart';
import '../../routes/app_routes.dart';

class BookingHistoryController extends GetxController {
  final BookingRepository _bookingRepo = Get.find();

  RxList<Booking> get allBookings => _bookingRepo.bookings;

  void goToTracking(Booking booking) {
    Get.toNamed(
      Routes.tracking,
      arguments: {'booking': booking},
    );
  }

  void goToInvoice(Booking booking) {
    Get.toNamed(
      Routes.invoiceDetail,
      arguments: {'booking': booking},
    );
  }
}
