import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../core/utils/dialog_util.dart';
import '../../data/models/vehicle.dart';
import '../../data/models/service_type.dart';
import '../../data/models/workshop.dart';
import '../../data/repositories/vehicle_repository.dart';
import '../../data/repositories/service_repository.dart';
import '../../data/repositories/workshop_repository.dart';
import '../../routes/app_routes.dart';

class HomeController extends GetxController {
  final VehicleRepository _vehicleRepo = Get.find();
  final ServiceRepository _serviceRepo = Get.find();
  final WorkshopRepository _workshopRepo = Get.find();

  final RxInt currentNavIndex = 0.obs;
  final RxBool isLoading = true.obs;

  final RxList<Vehicle> userVehicles = <Vehicle>[].obs;
  final RxList<ServiceType> serviceTypes = <ServiceType>[].obs;
  final RxList<Workshop> nearbyWorkshops = <Workshop>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    isLoading.value = true;
    try {
      final results = await Future.wait([
        _vehicleRepo.getVehicles(),
        _serviceRepo.getServiceTypes(),
        _workshopRepo.getWorkshops(),
      ]);

      userVehicles.assignAll(results[0] as List<Vehicle>);
      serviceTypes.assignAll(results[1] as List<ServiceType>);
      nearbyWorkshops.assignAll(results[2] as List<Workshop>);
    } catch (e) {
      debugPrint('loadDashboardData error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onNavTap(int index) async {
    switch (index) {
      case 0:
        currentNavIndex.value = 0;
        break;
      case 1:
        await Get.toNamed(Routes.bookingHistory);
        currentNavIndex.value = 0;
        break;
      case 2:
        DialogUtil.showUnderDevelopment(featureName: 'Halaman Profil');
        break;
    }
  }

  void startBookingFlow() {
    Get.toNamed(Routes.vehicleSelect);
  }
}
