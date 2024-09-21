import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef TestListPredicate<E> = bool Function(E e);
typedef ElementIndexedMapper<T, E> = T Function(E element, int index);
typedef ElementMapper<T, E> = T Function(E element);

extension ListsExtensions<E> on List<E> {

  int? firstIndexWhere(TestListPredicate<E> test) {
    final index = indexWhere((element) => test(element));
    if (index == -1) {
      return null;
    } else {
      return index;
    }
  }

  List<T> mapIndexed<T>(ElementIndexedMapper<T, E> mapper) {
    final list = <T>[];
    for (int i = 0; i < length; i++) {
      list.add(mapper(this[i], i));
    }
    return list;
  }

  E? getOrNull(int index) {
    if (index >= 0 && isNotEmpty) {
      return this[index];
    } else {
      return null;
    }
  }

  E? firstOrNull() {
    try {
      return first;
    } catch (e) {
      return null;
    }
  }

  E? lastOrNull() {
    try {
      return last;
    } catch (e) {
      return null;
    }
  }

  E? firstWhereOrNull(TestListPredicate<E> test) {
    try {
      return firstWhere(test);
    } catch (e) {
      return null;
    }
  }

  List<M> mapNotNull<M>(M? Function(E element) mapper) {
    final list = <M>[];
    forEach((element) {
      final item = mapper(element);
      if (item != null) {
        list.add(item);
      }
    });
    return list;
  }
}

extension WhereNotInExt<T> on Iterable<T> {
  Iterable<T> whereNotIn(Iterable<T> reject) {
    final rejectSet = reject.toSet();
    return where((el) => !rejectSet.contains(el));
  }
}

extension LocaleExtensions on Locale {
  String toLanguageCountry() {
    final country = countryCode ?? "EG";
    return "${languageCode}_$country";
  }
}

extension ConvertTimeStampToDateTime on int {
  DateTime mapToDateTime() {
    return DateTime.fromMicrosecondsSinceEpoch(this * 1000);
  }
}
// asd
extension DateTimeFormats on DateTime{
  //10 Oct, 2024
  String formatToDayMonthNameYear(Locale locale){
    return DateFormat("dd MMM, yyyy", locale.toLanguageCountry()).format(this);
  }
}

extension ConvertTimeStampToDateTimes on int {
  DateTime mapToDateTimes() {
    return DateTime.fromMillisecondsSinceEpoch(this);
  }
}

extension LargeNumbers on num{
  String get simplifyLargeNumber{
    String num = toString();
    int len = num.length;

    if (this >= 10000 && this < 1000000) {
      return '${num.substring(0, len - 3)}.${num.substring(len - 3, 1 + (len - 3))}K';
    } else if (this >= 1000000 && this < 1000000000) {
      return '${num.substring(0, len - 6)}.${num.substring(len - 6, 1 + (len - 6))}M';
    } else if (this > 1000000000) {
      return '${num.substring(0, len - 9)}.${num.substring(len - 9, 1 + (len - 9))}B';
    } else {
      return num.toString();
    }

  }
}


  extension ConvertDurationToTime on Duration{
  String  convertDurationToTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (twoDigits(duration.inHours) != '00') {
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    } else {
      return "$twoDigitMinutes:$twoDigitSeconds";
    }

  }
}

extension OrdinalNumbers on int{
  String ordinalNumbers(int index) {
    String prefix = "";
    String suffix;
    int number = index + 1;

    if (number % 10 == 1 && number % 100 != 11) {
      suffix = "st";
    } else if (number % 10 == 2 && number % 100 != 12) {
      suffix = "nd";
    } else if (number % 10 == 3 && number % 100 != 13) {
      suffix = "rd";
    } else {
      suffix = "th";
    }

    return '$prefix$number$suffix';
  }
}