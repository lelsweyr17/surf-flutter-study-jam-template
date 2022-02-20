extension Formatter on DateTime {
  String get formatted {
    final date = DateTime.now().isSameDay(this) ? "" : "$day.$month.$year ";
    final time = "$hour:$minute";
    final result = "$date$time";

    return result;
  }

  bool isSameDay(DateTime other) {
    return day == other.day && month == other.month && year == other.year;
  }
}
