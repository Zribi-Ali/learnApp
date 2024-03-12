// Define a simple format function from scratch

String simplyFormat({required DateTime time, bool dateOnly = false}) {
  String year = time.year.toString();

  // Add "0" on the left if month is from 1 to 9
  String month = time.month.toString().padLeft(2, '0');

  // Add "0" on the left if day is from 1 to 9
  String day = time.day.toString().padLeft(2, '0');

  // Add "0" on the left if hour is from 1 to 9
  String hour = time.hour.toString().padLeft(2, '0');

  // Add "0" on the left if minute is from 1 to 9
  String minute = time.minute.toString().padLeft(2, '0');

  // Add "0" on the left if second is from 1 to 9
  String second = time.second.toString();

  // If you only want year, month, and date
  if (dateOnly == false) {
    return "$year-$month-$day $hour:$minute:$second";
  }

  // return the "yyyy-MM-dd HH:mm:ss" format
  return "$year-$month-$day";
}

// Test our function
/*
void main() {
  DateTime currentTime = DateTime.now();
  // Full date and time
  final result1 = simplyFormat(time: currentTime);
  print(result1);
  // Date only
  final result2 = simplyFormat(time: currentTime, dateOnly: true);
  print(result2);
  // Kindacode.com
}
*/