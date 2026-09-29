import 'package:get/get.dart';
import '../models/booking.dart';
import '../models/booking_item.dart';
import '../models/vehicle.dart';
import '../models/service_type.dart';
import '../models/spare_part.dart';
import '../models/workshop.dart';

class BookingRepository extends GetxService {
  final RxList<Booking> bookings = <Booking>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initSeedBookings();
  }

  void _initSeedBookings() {
    final v1 = Vehicle(
      id: 'v1',
      name: 'Honda BeAT Street',
      type: 'Motor',
      brand: 'Honda',
      model: 'BeAT 110 CBS',
      plateNumber: 'B 4829 SKS',
      imageAsset: 'assets/images/beat.png',
    );
    final v2 = Vehicle(
      id: 'v2',
      name: 'Honda Vario 160',
      type: 'Motor',
      brand: 'Honda',
      model: 'Vario 160 ABS',
      plateNumber: 'B 3102 KJA',
      imageAsset: 'assets/images/vario.png',
    );

    final st1 = ServiceType(
      id: 'st1',
      name: 'Servis Ringan',
      description: 'Pemeriksaan umum & penyetelan',
      basePrice: 75000,
      estimatedMinutes: 45,
      icon: 'build_outlined',
    );
    final st2 = ServiceType(
      id: 'st2',
      name: 'Servis Berkala',
      description: 'Paket servis lengkap',
      basePrice: 150000,
      estimatedMinutes: 90,
      icon: 'published_with_changes_outlined',
    );

    final sp1 = SparePart(
      id: 'sp1',
      name: 'Oli MPX2 Matic 0.8L',
      category: 'Oli',
      price: 54000,
    );

    final ws1 = Workshop(
      id: 'ws1',
      name: 'AHASS Honda Astra Motor Pusat',
      address: 'Jl. Kramat Raya No. 104, Senen, Jakarta Pusat',
      distanceKm: 1.8,
      rating: 4.9,
      reviewCount: 1240,
      imageAsset: 'assets/images/workshop_1.png',
      openHours: '08:00 - 17:00',
    );

    final pastBooking = Booking(
      id: 'b1',
      code: 'SRV-20260928-8839',
      items: [
        BookingItem(
          vehicle: v1,
          serviceType: st1,
          selectedParts: [sp1],
          complaintNote: 'Suara CVT sedikit kasar saat akselerasi awal.',
          status: 'Dalam Pengerjaan',
        ),
        BookingItem(
          vehicle: v2,
          serviceType: st2,
          selectedParts: [sp1],
          complaintNote: 'Rem belakang agak dalam.',
          status: 'Dijadwalkan',
        ),
      ],
      workshop: ws1,
      scheduledDate: DateTime.now().add(const Duration(days: 1)),
      scheduledTime: '09:00',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      mechanicName: 'Budi Santoso (AHASS Master Mechanic)',
    );

    bookings.add(pastBooking);
  }

  Future<void> saveBooking(Booking booking) async {
    bookings.insert(0, booking);
  }

  Booking? getBookingById(String id) {
    return bookings.firstWhereOrNull((b) => b.id == id);
  }

  void updateRating(String bookingId, double rating, String review) {
    final index = bookings.indexWhere((b) => b.id == bookingId);
    if (index != -1) {
      bookings[index].userRating = rating;
      bookings[index].userReview = review;
      bookings.refresh();
    }
  }
}
