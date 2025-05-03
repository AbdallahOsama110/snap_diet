import 'package:intl/intl.dart';

String historyDateTimeFormat(DateTime dateTime) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final dateToCheck = DateTime(dateTime.year, dateTime.month, dateTime.day);

  String dayPrefix;
  if (dateToCheck == today) {
    dayPrefix = 'Today';
  } else if (dateToCheck == yesterday) {
    dayPrefix = 'Yesterday';
  } else {
    dayPrefix = DateFormat('MMM d').format(dateTime); // e.g., "Jul 15"
  }

  final timeFormat = DateFormat('h:mm a').format(dateTime); // e.g., "2:30 PM"
  
  return '$dayPrefix, $timeFormat';
}