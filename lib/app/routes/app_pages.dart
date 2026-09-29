import 'package:get/get.dart';

import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/vehicle_select/vehicle_select_binding.dart';
import '../modules/vehicle_select/vehicle_select_view.dart';
import '../modules/service_config/service_config_binding.dart';
import '../modules/service_config/service_config_view.dart';
import '../modules/schedule/schedule_binding.dart';
import '../modules/schedule/schedule_view.dart';
import '../modules/booking_summary/booking_summary_binding.dart';
import '../modules/booking_summary/booking_summary_view.dart';
import '../modules/booking_success/booking_success_binding.dart';
import '../modules/booking_success/booking_success_view.dart';
import '../modules/tracking/tracking_binding.dart';
import '../modules/tracking/tracking_view.dart';
import '../modules/workshop_rating/workshop_rating_binding.dart';
import '../modules/workshop_rating/workshop_rating_view.dart';
import '../modules/invoice_detail/invoice_detail_binding.dart';
import '../modules/invoice_detail/invoice_detail_view.dart';
import '../modules/booking_history/booking_history_binding.dart';
import '../modules/booking_history/booking_history_view.dart';
import '../modules/main/main_binding.dart';
import '../modules/main/main_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.main;

  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.vehicleSelect,
      page: () => const VehicleSelectView(),
      binding: VehicleSelectBinding(),
    ),
    GetPage(
      name: Routes.serviceConfig,
      page: () => const ServiceConfigView(),
      binding: ServiceConfigBinding(),
    ),
    GetPage(
      name: Routes.schedule,
      page: () => const ScheduleView(),
      binding: ScheduleBinding(),
    ),
    GetPage(
      name: Routes.bookingSummary,
      page: () => const BookingSummaryView(),
      binding: BookingSummaryBinding(),
    ),
    GetPage(
      name: Routes.bookingSuccess,
      page: () => const BookingSuccessView(),
      binding: BookingSuccessBinding(),
    ),
    GetPage(
      name: Routes.tracking,
      page: () => const TrackingView(),
      binding: TrackingBinding(),
    ),
    GetPage(
      name: Routes.workshopRating,
      page: () => const WorkshopRatingView(),
      binding: WorkshopRatingBinding(),
    ),
    GetPage(
      name: Routes.invoiceDetail,
      page: () => const InvoiceDetailView(),
      binding: InvoiceDetailBinding(),
    ),
    GetPage(
      name: Routes.bookingHistory,
      page: () => const BookingHistoryView(),
      binding: BookingHistoryBinding(),
    ),
    GetPage(
      name: Routes.main,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
  ];
}
