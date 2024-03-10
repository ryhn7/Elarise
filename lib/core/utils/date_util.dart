import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart'; // Add intl package for date formatting

class DateUtil {
  String formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays < 1) {
      // Use timeago for periods less than a day
      return timeago.format(dateTime);
    } else if (difference.inDays <= 7) {
      // Use custom message for periods up to 7 days
      return '${difference.inDays} days ago';
    } else {
      // Use DateFormat for periods over 7 days
      return DateFormat('d MMM y').format(dateTime); // e.g. '7 Mar 2024'
    }
  }
}
