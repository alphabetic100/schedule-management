import 'package:intl/intl.dart';

class AppHelpers {
  static String getFormattedToday() {
    final now = DateTime.now();
    return DateFormat('EEEE MMM d').format(now);
  }
}
