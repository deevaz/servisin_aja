import '../models/service_type.dart';
import '../models/spare_part.dart';
import '../providers/mock_data_provider.dart';

class ServiceRepository {
  final MockDataProvider _provider;

  ServiceRepository(this._provider);

  Future<List<ServiceType>> getServiceTypes() async {
    return await _provider.loadServiceTypes();
  }

  Future<List<SparePart>> getSpareParts() async {
    return await _provider.loadSpareParts();
  }
}
