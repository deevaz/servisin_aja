import 'booking_item.dart';
import 'workshop.dart';

class Booking {
  final String id;
  final String code;
  final List<BookingItem> items;
  final Workshop workshop;
  final DateTime scheduledDate;
  final String scheduledTime;
  final DateTime createdAt;
  final String mechanicName;
  double? userRating;
  String? userReview;

  Booking({
    required this.id,
    required this.code,
    required this.items,
    required this.workshop,
    required this.scheduledDate,
    required this.scheduledTime,
    required this.createdAt,
    this.mechanicName = 'Budi Santoso (Sertifikasi AHASS Gold)',
    this.userRating,
    this.userReview,
  });

  int get totalCost => items.fold<int>(0, (sum, item) => sum + item.subtotal);

  int get totalDuration => items.fold<int>(0, (sum, item) => sum + item.duration);

  String get overallStatus {
    if (items.isEmpty) return 'Menunggu Konfirmasi';
    if (items.every((i) => i.status == 'Selesai')) return 'Selesai';
    if (items.any((i) => i.status == 'Dalam Pengerjaan')) return 'Dalam Pengerjaan';
    if (items.any((i) => i.status == 'Dijadwalkan')) return 'Dijadwalkan';
    return 'Menunggu Konfirmasi';
  }
}
