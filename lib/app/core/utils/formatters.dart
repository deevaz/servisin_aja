import 'package:intl/intl.dart';

class Formatters {
  Formatters._();

  static String rupiah(num amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  static String duration(int minutes) {
    if (minutes <= 0) return '0 menit';
    if (minutes >= 1440) {
      final days = minutes ~/ 1440;
      final remainingMins = minutes % 1440;
      if (remainingMins == 0) {
        return '$days hari';
      } else {
        return '$days hari ${duration(remainingMins)}';
      }
    } else if (minutes >= 60) {
      final hours = minutes ~/ 60;
      final remainingMins = minutes % 60;
      if (remainingMins == 0) {
        return '$hours jam';
      } else {
        return '$hours jam $remainingMins menit';
      }
    } else {
      return '$minutes menit';
    }
  }

  static String formatDate(DateTime date) {
    final formatter = DateFormat('EEEE, d MMMM yyyy', 'id_ID');
    return formatter.format(date);
  }

  static String formatShortDate(DateTime date) {
    final formatter = DateFormat('d MMM', 'id_ID');
    return formatter.format(date);
  }
}
