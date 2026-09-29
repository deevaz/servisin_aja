import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servisin_aja/app/core/utils/snackbar_util.dart';
import '../../data/models/workshop.dart';
import '../../data/models/time_slot.dart';
import '../../data/models/booking_item.dart';
import '../../data/repositories/workshop_repository.dart';
import '../../routes/app_routes.dart';

class ScheduleController extends GetxController {
  final WorkshopRepository _workshopRepo = Get.find();

  final RxList<Workshop> workshops = <Workshop>[].obs;
  final Rx<Workshop?> selectedWorkshop = Rx<Workshop?>(null);

  final RxList<DateTime> availableDates = <DateTime>[].obs;
  final Rx<DateTime> selectedDate = DateTime.now()
      .add(const Duration(days: 1))
      .obs;

  final RxList<TimeSlot> timeSlots = <TimeSlot>[].obs;
  final RxString selectedTime = ''.obs;

  final RxBool isLoading = true.obs;
  List<BookingItem> bookingItems = [];

  @override
  void onInit() {
    super.onInit();
    bookingItems = Get.arguments?['bookingItems'] ?? [];
    initScheduleData();
  }

  Future<void> initScheduleData() async {
    isLoading.value = true;
    try {
      final today = DateTime.now();
      availableDates.assignAll(
        List.generate(
          7,
          (i) => DateTime(today.year, today.month, today.day + i + 1),
        ),
      );
      selectedDate.value = availableDates[0];

      final wsList = await _workshopRepo.getWorkshops();
      workshops.assignAll(wsList);
      if (workshops.isNotEmpty) {
        selectedWorkshop.value = workshops[0];
      }

      await fetchTimeSlots();
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchTimeSlots() async {
    final slots = await _workshopRepo.getTimeSlotsForDate(selectedDate.value);
    timeSlots.assignAll(slots);
    final available = slots.firstWhereOrNull((s) => s.available);
    if (available != null) {
      selectedTime.value = available.time;
    } else {
      selectedTime.value = '';
    }
  }

  void selectWorkshop(Workshop ws) {
    selectedWorkshop.value = ws;
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
    fetchTimeSlots();
  }

  void selectTimeSlot(String time) {
    selectedTime.value = time;
  }

  bool get isValid {
    return selectedWorkshop.value != null && selectedTime.value.isNotEmpty;
  }

  void proceedToSummary() {
    if (!isValid) {
      SnackbarUtil.info(
        'Lengkapi Jadwal',
        'Silakan pilih bengkel dan jam operasional servis.',
      );
      return;
    }

    Get.toNamed(
      Routes.bookingSummary,
      arguments: {
        'bookingItems': bookingItems,
        'workshop': selectedWorkshop.value,
        'scheduledDate': selectedDate.value,
        'scheduledTime': selectedTime.value,
      },
    );
  }
}
