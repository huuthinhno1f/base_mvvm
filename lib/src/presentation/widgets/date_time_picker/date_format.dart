import 'i18n_model.dart';

const String ymdw = 'ymdw';
const String yyyy = 'yyyy';
const String yy = 'yy';
const String mm = 'mm';
const String m = 'm';
const String MM = 'MM';
const String M = 'M';
const String dd = 'dd';
const String d = 'd';
const String w = 'w';
const String WW = 'WW';
const String W = 'W';
const String D = 'D';
const String hh = 'hh';
const String h = 'h';
const String HH = 'HH';
const String H = 'H';
const String nn = 'nn';
const String n = 'n';
const String ss = 'ss';
const String s = 's';
const String SSS = 'SSS';
const String S = 'S';
const String uuu = 'uuu';
const String u = 'u';
const String am = 'am';
const String z = 'z';
const String Z = 'Z';

String formatDate(DateTime date, List<String> formats, LocaleType locale) {
  if (formats.first == ymdw) {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      //today
      return i18nObjInLocale(locale)['today'] as String;
    } else if (date.year == now.year) {
      if (locale == LocaleType.zh) {
        return formatDate(date, [mm, '月', dd, '日 ', D], locale);
      } else if (locale == LocaleType.nl) {
        return formatDate(date, [D, ' ', dd, ' ', M], locale);
      } else if (locale == LocaleType.ko) {
        return formatDate(date, [mm, '월', dd, '일 ', D], locale);
      } else if (locale == LocaleType.de) {
        return formatDate(date, [D, ', ', dd, '. ', M], locale);
      } else if (locale == LocaleType.id) {
        return formatDate(date, [D, ', ', dd, ' ', M], locale);
      } else if (locale == LocaleType.jp) {
        return formatDate(date, [mm, '月', dd, '日', D], locale);
      } else if (locale == LocaleType.si) {
        return formatDate(date, [D, ', ', dd, '. ', M, '.'], locale);
      } else if (locale == LocaleType.gr) {
        return formatDate(date, [D, ' ', dd, ' ', M], locale);
      } else {
        return formatDate(date, [D, ' ', M, ' ', dd], locale);
      }
    } else {
      if (locale == LocaleType.zh) {
        return formatDate(date, [yyyy, '年', mm, '月', dd, '日 ', D], locale);
      } else if (locale == LocaleType.nl) {
        return formatDate(date, [D, ' ', dd, ' ', M, ' ', yyyy], locale);
      } else if (locale == LocaleType.ko) {
        return formatDate(date, [yyyy, '년', mm, '월', dd, '일 ', D], locale);
      } else if (locale == LocaleType.de) {
        return formatDate(date, [D, ', ', dd, '. ', M, ' ', yyyy], locale);
      } else if (locale == LocaleType.id) {
        return formatDate(date, [D, ', ', dd, ' ', M, ' ', yyyy], locale);
      } else if (locale == LocaleType.jp) {
        return formatDate(date, [yyyy, '年', mm, '月', dd, '日', D], locale);
      } else if (locale == LocaleType.si) {
        return formatDate(date, [D, ', ', dd, '. ', M, '. ', yyyy], locale);
      } else if (locale == LocaleType.gr) {
        return formatDate(date, [D, ' ', dd, ' ', M, ' ', yyyy], locale);
      } else {
        return formatDate(date, [D, ' ', M, ' ', dd, ', ', yyyy], locale);
      }
    }
  }

  final sb = StringBuffer();

  for (String format in formats) {
    if (format == yyyy) {
      sb.write(digits(date.year, 4));
    } else if (format == yy) {
      sb.write(digits(date.year % 100, 2));
    } else if (format == mm) {
      sb.write(digits(date.month, 2));
    } else if (format == m) {
      sb.write(date.month);
    } else if (format == MM) {
      final monthLong = i18nObjInLocaleLookup(locale, 'monthLong', date.month - 1);
      sb.write(monthLong);
    } else if (format == M) {
      final monthShort = i18nObjInLocaleLookup(locale, 'monthShort', date.month - 1);
      sb.write(monthShort);
    } else if (format == dd) {
      sb.write(digits(date.day, 2));
    } else if (format == d) {
      sb.write(date.day);
    } else if (format == w) {
      sb.write((date.day + 7) ~/ 7);
    } else if (format == W) {
      sb.write((dayInYear(date) + 7) ~/ 7);
    } else if (format == WW) {
      sb.write(digits((dayInYear(date) + 7) ~/ 7, 2));
    } else if (format == D) {
      String day = i18nObjInLocaleLookup(locale, 'day', date.weekday - 1);
      if (locale == LocaleType.ko) {
        day = "($day)";
      }
      sb.write(day);
    } else if (format == HH) {
      sb.write(digits(date.hour, 2));
    } else if (format == H) {
      sb.write(date.hour);
    } else if (format == hh) {
      sb.write(digits(date.hour % 12, 2));
    } else if (format == h) {
      sb.write(date.hour % 12);
    } else if (format == am) {
      sb.write(date.hour < 12 ? i18nObjInLocale(locale)['am'] : i18nObjInLocale(locale)['pm']);
    } else if (format == nn) {
      sb.write(digits(date.minute, 2));
    } else if (format == n) {
      sb.write(date.minute);
    } else if (format == ss) {
      sb.write(digits(date.second, 2));
    } else if (format == s) {
      sb.write(date.second);
    } else if (format == SSS) {
      sb.write(digits(date.millisecond, 3));
    } else if (format == S) {
      sb.write(date.second);
    } else if (format == uuu) {
      sb.write(digits(date.microsecond, 2));
    } else if (format == u) {
      sb.write(date.microsecond);
    } else if (format == z) {
      if (date.timeZoneOffset.inMinutes == 0) {
        sb.write('Z');
      } else {
        if (date.timeZoneOffset.isNegative) {
          sb.write('-');
          sb.write(digits((-date.timeZoneOffset.inHours) % 24, 2));
          sb.write(digits((-date.timeZoneOffset.inMinutes) % 60, 2));
        } else {
          sb.write('+');
          sb.write(digits(date.timeZoneOffset.inHours % 24, 2));
          sb.write(digits(date.timeZoneOffset.inMinutes % 60, 2));
        }
      }
    } else if (format == Z) {
      sb.write(date.timeZoneName);
    } else {
      sb.write(format);
    }
  }

  return sb.toString();
}

String digits(int value, int length) {
  return '$value'.padLeft(length, "0");
}

int dayInYear(DateTime date) => date.difference(DateTime(date.year, 1, 1)).inDays;
