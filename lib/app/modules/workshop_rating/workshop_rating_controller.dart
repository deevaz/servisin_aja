import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/core/utils/snackbar_util.dart';
import 'package:get/get.dart';
import '../../data/models/booking.dart';
import '../../data/repositories/booking_repository.dart';

class WorkshopRatingController extends GetxController {
  final BookingRepository _bookingRepo = Get.find();

  late Booking booking;
  final RxDouble rating = 5.0.obs;
  final reviewController = TextEditingController();
  final RxBool isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments ?? {};
    final arg = args['booking'] as Booking?;
    if (arg == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => Get.back());
      return;
    }
    booking = arg;
    if (booking.userRating != null) {
      rating.value = booking.userRating!;
      reviewController.text = booking.userReview ?? '';
    }
  }

  void setRating(double value) {
    rating.value = value;
  }

  Future<void> submitReview() async {
    isSubmitting.value = true;
    try {
      _bookingRepo.updateRating(
        booking.id,
        rating.value,
        reviewController.text.trim(),
      );
      Get.back();
      SnackbarUtil.notification(
        'Terima Kasih!',
        'Ulasan Anda telah tersimpan. Masukan Anda sangat berharga bagi kami.',
      );
    } catch (e) {
      SnackbarUtil.error('Gagal!', 'Gagal menyimpan ulasan.');
    } finally {
      isSubmitting.value = false;
    }
  }
}
