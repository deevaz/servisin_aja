class TimeSlot {
  final DateTime date;
  final String time;
  final bool available;

  TimeSlot({required this.date, required this.time, this.available = true});
}
