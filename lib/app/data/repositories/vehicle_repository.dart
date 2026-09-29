import '../models/vehicle.dart';
import '../providers/mock_data_provider.dart';

class VehicleRepository {
  final MockDataProvider _provider;

  VehicleRepository(this._provider);

  Future<List<Vehicle>> getVehicles() async {
    return await _provider.loadVehicles();
  }

  Future<void> addVehicle(Vehicle vehicle) async {}
}
