String getFormattedDateTime(DateTime dateTime) {
  final minute = dateTime.minute < 10
      ? '0' + dateTime.minute.toString()
      : dateTime.minute.toString();
  final hour = dateTime.hour < 10
      ? '0' + dateTime.hour.toString()
      : dateTime.hour.toString();
  late final month;
  switch (dateTime.month) {
    case DateTime.january:
      month = 'January';
      break;
    case DateTime.february:
      month = 'February';
      break;
    case DateTime.march:
      month = 'March';
      break;
    case DateTime.april:
      month = 'April';
      break;
    case DateTime.may:
      month = 'May';
      break;
    case DateTime.june:
      month = 'June';
      break;
    case DateTime.july:
      month = 'July';
      break;
    case DateTime.august:
      month = 'August';
      break;
    case DateTime.september:
      month = 'September';
      break;
    case DateTime.october:
      month = 'October';
      break;
    case DateTime.november:
      month = 'November';
      break;
    case DateTime.september:
      month = 'September';
      break;
    case DateTime.december:
      month = 'December';
      break;
  }
  return '${dateTime.day} $month $hour:$minute';
}
