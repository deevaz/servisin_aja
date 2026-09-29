import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/core/utils/snackbar_util.dart';
import 'package:get/get.dart';
import '../../data/models/booking.dart';

class InvoiceDetailController extends GetxController {
  late Booking booking;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments ?? {};
    booking = args['booking'];
  }

  void downloadPdfInvoice() {
    SnackbarUtil.info(
      'Unduh Invoice',
      'Invoice PDF untuk ${booking.code} berhasil diunduh ke folder Dokumen.',
    );
  }
}
