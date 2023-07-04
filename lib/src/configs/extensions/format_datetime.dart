import 'package:intl/intl.dart';

extension DurationExtension on Duration {
  String toTime() {
    return toString().substring(2, 7);
  }
}

extension DateHelperExtension on DateTime {
  int dateDifference(DateTime secondDate) {
    return DateTime.utc(year, month, day).difference(DateTime.utc(secondDate.year, secondDate.month, secondDate.day)).inDays;
  }

  DateTime addDate(int days) {
    return DateTime(year, month, day).add(Duration(days: days));
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
  bool isToday( ) {
    return year == DateTime.now().year && month == DateTime.now().month && day == DateTime.now().day;
  }

  bool isInRange(DateTime startDate, DateTime endDate) {
    return (isAfter(startDate) || isSameDate(startDate)) && (isBefore(endDate) || isSameDate(endDate));
  }

  String getGregorianWeekDayAndDate() {
    final f = DateFormat('EEEE, MMM d');

    return f.format(this);
  }

  String formatDate({String? formatType}) {
    return DateFormat(formatType ?? 'dd MM yyyy').format(this);
  }

  String formatShortDate({String? formatType}) {
    return DateFormat(formatType ?? 'dd MM yy').format(this);
  }

  String formatTime({String? formatType}) {
    return DateFormat(formatType ?? 'HH:mm').format(this);
  }
}
