import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String dayString() {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(const Duration(days: 1));
    if (_isSameDay(this, now)) {
      return "Today, ${DateFormat('d MMMM', "en").format(this)}";
    } else if (_isSameDay(this, yesterday)) {
      return "Yesterday, ${DateFormat('d MMMM', "en").format(this)}";
    } else {
      return DateFormat('d MMMM', "en").format(this);
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
