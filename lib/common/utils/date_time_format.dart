import 'package:intl/intl.dart';

String convertDateToEnglishFullDate(DateTime date) {
  final currentDateTime = (DateFormat('E d MMMM y').parse(DateFormat(
    'E d MMMM y',
  ).format(date)));

  var result = DateFormat(
    'E d MMMM y',
  ).format(currentDateTime);

  return result;
}

//7 June, 2024
String convertDateToEnglishStartDay(DateTime date) {
  final currentDateTime = (DateFormat('d MMMM, y').parse(DateFormat(
    'd MMMM, y',
  ).format(date)));

  var result = DateFormat(
    'd MMMM, y',
  ).format(currentDateTime);

  return result;
}
String convertDateToEnglishStartDayYMMD(DateTime date) {
  final currentDateTime = (DateFormat('MMMM d, y').parse(DateFormat(
    'MMMM d, y',
  ).format(date)));

  var result = DateFormat(
    'MMMM d, y',
  ).format(currentDateTime);

  return result;
}

int getTimeStampOfDay(DateTime date) {
  return date.millisecondsSinceEpoch;
}

int dateTimeOfTomorrow() {
  var today = DateTime.now();
  final tomorrow = DateTime(
    today.year,
    today.month,
    today.day + 1,
  );
  return tomorrow.millisecondsSinceEpoch;
}

int dateTimeOfNextMonth() {
  var today = DateTime.now();
  final nextMonth = DateTime(
    today.year,
    today.month + 1,
    today.day,
  );
  return nextMonth.millisecondsSinceEpoch;
}

int dateTimeOfNextThreeMonth() {
  var today = DateTime.now();
  final threeMonth = DateTime(
    today.year,
    today.month + 3,
    today.day,
  );
  return threeMonth.millisecondsSinceEpoch;
}

int dateTimeOfNextSixMonth() {
  var today = DateTime.now();
  final sixMonth = DateTime(
    today.year,
    today.month + 6,
    today.day,
  );
  return sixMonth.millisecondsSinceEpoch;
}

int dateTimeOfNextYear() {
  var today = DateTime.now();
  final nextYear = DateTime(
    today.year + 1,
    today.month,
    today.day,
  );
  return nextYear.millisecondsSinceEpoch;
}

String convertTimeStampToFullDate({required int timeStamp, String? lang}) {
  var x = DateTime.fromMillisecondsSinceEpoch(timeStamp);

  final currentDateTime =
      (DateFormat('y-MM-d').parse(DateFormat('y-MM-d').format(x)));

  var result = DateFormat(
    'dd MMM , y',
  ).format(currentDateTime);

  return result;
}

String convertTimeStampWithName({required int timeStamp, String? lang}) {
  var x = DateTime.fromMillisecondsSinceEpoch(timeStamp);

  final currentDateTime =
      (DateFormat('y-MM-d').parse(DateFormat('y-MM-d').format(x)));

  var result = DateFormat(
    'dd MMM , y',
  ).format(currentDateTime);

  return result;
}

//7 - 14 January, 2024
String convertTimeStampToMonthAndYear({required int timeStamp, String? lang}) {
  var x = DateTime.fromMillisecondsSinceEpoch(timeStamp);

  final currentDateTime = (DateFormat('d').parse(DateFormat('d').format(x)));

  var result = DateFormat(
    'MMM dd, y',
  ).format(currentDateTime);

  return result;
}

//Aug 23 , 2023
String convertTimeStampWithNameStartByMonth(
    {required int timeStamp, String? lang}) {
  var x = DateTime.fromMillisecondsSinceEpoch(timeStamp);

  final currentDateTime =
  (DateFormat('y-MM-d').parse(DateFormat('y-MM-d').format(x)));

  var result = DateFormat(
    'MMM dd, y',
  ).format(currentDateTime);

  return result;
}

//23 Aug, 2023 - 25 Aug, 2023
String convertTimeStampWithNameFullDate(
    {required int timeStamp, String? lang}) {
  var x = DateTime.fromMillisecondsSinceEpoch(timeStamp);

  final currentDateTime =
      (DateFormat('y-MM-d').parse(DateFormat('y-MM-d').format(x)));

  var result = DateFormat(
    'dd MMM , y',
  ).format(currentDateTime);

  return result;
}

String convertTimeStampToEnglishFullDateStartYear(int timeStamp) {
  var x = DateTime.fromMillisecondsSinceEpoch(timeStamp);

  final currentDateTime = (DateFormat('d-MM-y').parse(DateFormat(
    'd-MM-y',
  ).format(x)));

  var result = DateFormat(
    'MM-y',
  ).format(currentDateTime);

  return result;
}

String convertTimeStampToEnglishFullDateStartDay(int timeStamp) {
  var x = DateTime.fromMillisecondsSinceEpoch(timeStamp);

  final currentDateTime = (DateFormat('dd MMM y').parse(DateFormat(
    'dd MMM y',
  ).format(x)));

  var result = DateFormat(
    'dd MMM y',
  ).format(currentDateTime);

  return result;
}

String convertIntMonthToStringMonth (int month){
  switch(month){
    case 1:
      return "January";
    case 2:
      return "February";
    case 3:
      return "March";
    case 4:
      return "April";
    case 5:
      return "May";
    case 6:
      return "June";
    case 7:
      return "July";
    case 8:
      return "August";
    case 9:
      return "September";
    case 10:
      return "October";
    case 11:
      return "November";
    case 12:
      return "December";

  }
  return "";

}

String convertDateToEnglishStartDayWithoutDay(DateTime date) {
  final currentDateTime = (DateFormat('MMMM, y').parse(DateFormat(
    'MMMM, y',
  ).format(date)));

  var result = DateFormat(
    'MMMM, y',
  ).format(currentDateTime);

  return result;
}
DateTime convertIntToDateTime(int timeStamp) {
  final time = DateTime.fromMillisecondsSinceEpoch(timeStamp);

  return time;
}
