import '../models/workshop.dart';
import '../models/time_slot.dart';
import '../providers/mock_data_provider.dart';

class WorkshopRepository {
  final MockDataProvider _provider;

  WorkshopRepository(this._provider);

  Future<List<Workshop>> getWorkshops() async {
    return await _provider.loadWorkshops();
  }

  Future<List<TimeSlot>> getTimeSlotsForDate(DateTime date) async {
    final times = [
      '08:00',
      '09:00',
      '10:00',
      '11:00',
      '13:00',
      '14:00',
      '15:00',
      '16:00',
    ];
    final slots = <TimeSlot>[];
    for (int i = 0; i < times.length; i++) {
      final isUnavailable = (date.day + i) % 5 == 0;
      slots.add(
        TimeSlot(date: date, time: times[i], available: !isUnavailable),
      );
    }
    return slots;
  }
}
