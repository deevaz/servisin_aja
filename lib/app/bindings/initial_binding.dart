import 'package:get/get.dart';
import '../data/providers/mock_data_provider.dart';
import '../data/repositories/vehicle_repository.dart';
import '../data/repositories/service_repository.dart';
import '../data/repositories/workshop_repository.dart';
import '../data/repositories/booking_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MockDataProvider>(() => MockDataProvider(), fenix: true);
    Get.lazyPut<VehicleRepository>(() => VehicleRepository(Get.find()), fenix: true);
    Get.lazyPut<ServiceRepository>(() => ServiceRepository(Get.find()), fenix: true);
    Get.lazyPut<WorkshopRepository>(() => WorkshopRepository(Get.find()), fenix: true);
    Get.put<BookingRepository>(BookingRepository(), permanent: true);
  }
}
