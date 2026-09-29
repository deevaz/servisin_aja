import 'vehicle.dart';
import 'service_type.dart';
import 'spare_part.dart';

class BookingItem {
  final Vehicle vehicle;
  ServiceType? serviceType;
  List<SparePart> selectedParts;
  String complaintNote;
  String status;

  BookingItem({
    required this.vehicle,
    this.serviceType,
    List<SparePart>? selectedParts,
    this.complaintNote = '',
    this.status = 'Menunggu Konfirmasi',
  }) : selectedParts = selectedParts ?? [];

  int get subtotal {
    final base = serviceType?.basePrice ?? 0;
    final partsTotal = selectedParts.fold<int>(0, (sum, part) => sum + part.price);
    return base + partsTotal;
  }

  int get duration {
    return serviceType?.estimatedMinutes ?? 0;
  }

  BookingItem copyWith({
    Vehicle? vehicle,
    ServiceType? serviceType,
    List<SparePart>? selectedParts,
    String? complaintNote,
    String? status,
  }) {
    return BookingItem(
      vehicle: vehicle ?? this.vehicle,
      serviceType: serviceType ?? this.serviceType,
      selectedParts: selectedParts ?? List.from(this.selectedParts),
      complaintNote: complaintNote ?? this.complaintNote,
      status: status ?? this.status,
    );
  }
}
