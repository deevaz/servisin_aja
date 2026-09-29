import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/vehicle.dart';
import '../../data/models/service_type.dart';
import '../../data/models/spare_part.dart';
import '../../data/models/booking_item.dart';
import '../../data/repositories/service_repository.dart';
import '../../routes/app_routes.dart';

class ServiceConfigController extends GetxController {
  final ServiceRepository _serviceRepo = Get.find();

  final RxList<BookingItem> bookingItems = <BookingItem>[].obs;
  final RxList<ServiceType> availableServices = <ServiceType>[].obs;
  final RxList<SparePart> availableParts = <SparePart>[].obs;

  final RxBool isLoading = true.obs;
  final RxMap<String, bool> expandedCards = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future<void> initData() async {
    isLoading.value = true;
    try {
      final services = await _serviceRepo.getServiceTypes();
      final parts = await _serviceRepo.getSpareParts();
      availableServices.assignAll(services);
      availableParts.assignAll(parts);

      final List<Vehicle> selectedVehicles =
          Get.arguments?['selectedVehicles'] ?? [];

      bookingItems.assignAll(
        selectedVehicles.map((v) {
          expandedCards[v.id] = selectedVehicles.indexOf(v) == 0;
          return BookingItem(
            vehicle: v,
            serviceType: services.isNotEmpty ? services[0] : null,
            selectedParts: [],
            complaintNote: '',
          );
        }).toList(),
      );
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

  void toggleCardExpanded(String vehicleId) {
    final current = expandedCards[vehicleId] ?? false;
    expandedCards[vehicleId] = !current;
  }

  void selectServiceForVehicle(String vehicleId, ServiceType service) {
    final index = bookingItems.indexWhere(
      (item) => item.vehicle.id == vehicleId,
    );
    if (index != -1) {
      final currentItem = bookingItems[index];
      bookingItems[index] = currentItem.copyWith(serviceType: service);
      bookingItems.refresh();
    }
  }

  void togglePartForVehicle(String vehicleId, SparePart part) {
    final index = bookingItems.indexWhere(
      (item) => item.vehicle.id == vehicleId,
    );
    if (index != -1) {
      final currentItem = bookingItems[index];
      final currentParts = List<SparePart>.from(currentItem.selectedParts);

      if (currentParts.any((p) => p.id == part.id)) {
        currentParts.removeWhere((p) => p.id == part.id);
      } else {
        currentParts.add(part);
      }

      bookingItems[index] = currentItem.copyWith(selectedParts: currentParts);
      bookingItems.refresh();
    }
  }

  void updateComplaintForVehicle(String vehicleId, String note) {
    final index = bookingItems.indexWhere(
      (item) => item.vehicle.id == vehicleId,
    );
    if (index != -1) {
      bookingItems[index].complaintNote = note;
      bookingItems.refresh();
    }
  }

  int get grandTotalCost {
    return bookingItems.fold<int>(0, (sum, item) => sum + item.subtotal);
  }

  int get grandTotalDuration {
    return bookingItems.fold<int>(0, (sum, item) => sum + item.duration);
  }

  bool get isValid {
    return bookingItems.isNotEmpty &&
        bookingItems.every((item) => item.serviceType != null);
  }

  void proceedToSchedule() {
    if (!isValid) {
      Get.snackbar(
        'Lengkapi Layanan',
        'Pastikan setiap kendaraan sudah memiliki jenis servis yang dipilih.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    Get.toNamed(
      Routes.schedule,
      arguments: {'bookingItems': bookingItems.toList()},
    );
  }
}
