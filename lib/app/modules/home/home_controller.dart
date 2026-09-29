import 'package:get/get.dart';
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
      final vehicles = await _vehicleRepo.getVehicles();
      final services = await _serviceRepo.getServiceTypes();
      final workshops = await _workshopRepo.getWorkshops();

      userVehicles.assignAll(vehicles);
      serviceTypes.assignAll(services);
      nearbyWorkshops.assignAll(workshops);
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void onNavTap(int index) {
    currentNavIndex.value = index;
    if (index == 1) {
      Get.toNamed(Routes.bookingHistory);
      currentNavIndex.value = 0;
    }
  }

  void startBookingFlow() {
    Get.toNamed(Routes.vehicleSelect);
  }
}
