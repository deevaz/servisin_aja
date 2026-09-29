import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/booking.dart';
import '../../routes/app_routes.dart';

class BookingSuccessController extends GetxController {
  Booking? booking;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments ?? {};
    booking = args['booking'] as Booking?;
    if (booking == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed(Routes.home);
      });
    }
  }

  void goToTracking() {
    if (booking == null) return;
    Get.toNamed(Routes.tracking, arguments: {'booking': booking});
  }

  void goToHome() {
    Get.offAllNamed(Routes.home);
  }
}
