import 'package:get/get.dart';
import 'package:servisin_aja/app/core/utils/snackbar_util.dart';
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
