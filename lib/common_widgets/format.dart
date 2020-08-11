import 'package:intl/intl.dart';

class Format {
  static String hours(double hours) {
    final hoursNotNegative = hours < 0.0 ? 0.0 : hours;
    final formatter = NumberFormat.decimalPattern();
    final formatted = formatter.format(hoursNotNegative);
    return '${formatted}h';
  }
}
