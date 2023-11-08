import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

/// ENV
extension ENVUtil on String {
  String env() {
    return dotenv.env[this] ?? "";
  }
}

/// DateTime
extension DateFormatUtil on String? {
  DateFormat get formatPatternInput => DateFormat("yyyy-MM-ddTkk:mm:ss");

  DateFormat get formatPatternOutput => DateFormat("yyyy-MM-ddTkk:mm:ss");

  String get defaultFormat => "kk:mm:ss dd-MM-yyyy";

  DateTime? get toDate {
    if (this == null) return null;
    try {
      return formatPatternInput.parse(this!);
    } catch (e) {
      return null;
    }
  }

  String get toDateString {
    final date = toDate;
    if (date == null) return "";
    return formatPatternOutput.format(date);
  }

  String toDatePattern(String? patternInput, String? patternOutput) {
    if (this == null) return "";
    try {
      final date = DateFormat(patternInput).parse(this!);
      return DateFormat(patternOutput).format(date);
    } catch (e) {
      return "";
    }
  }
}

extension DateTimeFormat on DateTime? {
  DateFormat get formatPattern => DateFormat("dd-MM-yyyy");

  String get toDateString {
    if (this == null) return "";
    try {
      return formatPattern.format(this!);
    } catch (e) {
      return "";
    }
  }

  String toPattern({String? pattern}) {
    if (this == null) return "";
    try {
      final fm = pattern != null ? DateFormat(pattern) : formatPattern;
      return fm.format(this!);
    } catch (e) {
      return "";
    }
  }
}

String formatedTime(int secTime) {
  String getParsedTime(String time) {
    if (time.length <= 1) return "0$time";
    return time;
  }

  int day = secTime ~/ 86400;
  int min = (secTime % 86400) ~/ 3600;
  int sec = (secTime % 3600) ~/ 60;
  if (day > 0) {
    return "${getParsedTime(day.toString())} Ngày ${getParsedTime(min.toString())} Giờ ${getParsedTime(sec.toString())} Phút ";
  } else if (min > 0) {
    return "${getParsedTime(min.toString())} Giờ ${getParsedTime(sec.toString())} Phút ";
  } else {
    return "${getParsedTime(sec.toString())} Phút ";
  }
}

getTime(String timeBook) {
  var dateOfBirth = DateTime.parse(timeBook);
  var currentDate = DateTime.now();
  var different = dateOfBirth.difference(currentDate);
  return formatedTime(different.inSeconds);
}

formatTimeToString(date) {
  var inputDate = DateTime.parse(date.toString());
  var outputFormat = DateFormat('HH:mm dd/MM/yyyy');
  var outputDate = outputFormat.format(inputDate);
  return outputDate;
}
