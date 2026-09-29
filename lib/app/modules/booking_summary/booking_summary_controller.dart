import 'package:flutter_application_1/app/core/utils/snackbar_util.dart';
import 'package:get/get.dart';
import '../../data/models/booking.dart';
import '../../data/models/booking_item.dart';
import '../../data/models/workshop.dart';
import '../../data/repositories/booking_repository.dart';
import '../../routes/app_routes.dart';

class BookingSummaryController extends GetxController {
  final BookingRepository _bookingRepo = Get.find();

  late List<BookingItem> bookingItems;
  late Workshop workshop;
  late DateTime scheduledDate;
  late String scheduledTime;

  final RxBool isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments ?? {};
    bookingItems = args['bookingItems'] ?? [];
    workshop = args['workshop'];
    scheduledDate = args['scheduledDate'] ?? DateTime.now();
    scheduledTime = args['scheduledTime'] ?? '09:00';
  }

  int get grandTotalCost {
    return bookingItems.fold<int>(0, (sum, item) => sum + item.subtotal);
  }

  int get grandTotalDuration {
    return bookingItems.fold<int>(0, (sum, item) => sum + item.duration);
  }

  Future<void> confirmBooking() async {
    isSubmitting.value = true;
    try {
      final code =
          'SRV-${DateTime.now().year}${DateTime.now().month.toString().padLeft(2, '0')}${DateTime.now().day.toString().padLeft(2, '0')}-${(1000 + (DateTime.now().millisecondsSinceEpoch % 8999))}';

      final booking = Booking(
        id: 'b_${DateTime.now().millisecondsSinceEpoch}',
        code: code,
        items: bookingItems
            .map((item) => item.copyWith(status: 'Menunggu Konfirmasi'))
            .toList(),
        workshop: workshop,
        scheduledDate: scheduledDate,
        scheduledTime: scheduledTime,
        createdAt: DateTime.now(),
      );

      await _bookingRepo.saveBooking(booking);

      Get.offAllNamed(Routes.bookingSuccess, arguments: {'booking': booking});
    } catch (e) {
      SnackbarUtil.error(
        'Gagal Booking',
        'Terjadi kesalahan saat memproses booking. Coba lagi.',
      );
    } finally {
      isSubmitting.value = false;
    }
  }
}
