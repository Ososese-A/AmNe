Duration parseDuration(String input) {
  final RegExp regex = RegExp(r'(\d+)([dhms])'); // Matches numbers and time units
  final Match? match = regex.firstMatch(input);

  if (match != null) {
    final int value = int.parse(match.group(1)!);
    final String unit = match.group(2)!;

    switch (unit) {
      case 'd':
        return Duration(days: value);
      case 'h':
        return Duration(hours: value);
      case 'm':
        return Duration(minutes: value);
      case 's':
        return Duration(seconds: value);
      default:
        throw FormatException('Invalid time unit: $unit');
    }
  } else {
    throw FormatException('Invalid format: $input');
  }
}

todaysDate () {
  DateTime today = DateTime.now();
  return today;
}

bool timeExpiry (start, lifeTIme) {
  DateTime startDate = DateTime.parse(start);
  Duration duration = parseDuration(lifeTIme);

  DateTime now = DateTime.now();

  DateTime expiryDate = startDate.add(duration);

  if (now.isAfter(expiryDate)) {
    return true;
  } else {
    return false;
  }
}