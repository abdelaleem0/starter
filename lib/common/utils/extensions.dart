import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:starter/common/utils/localization/common_localizer.dart';

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

  E? secondOrNull() {
    try {
      return this[1];
    } catch (e) {
      return null;
    }
  }

  E? thirdOrNull() {
    try {
      return this[2];
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

extension PrettyDateExtensions on DateTime {
  static const int oneSecond = 1000;
  static const int oneMinute = 60 * oneSecond;
  static const int oneHour = 60 * oneMinute;
  static const int oneDay = 24 * oneHour;
  static const int oneWeek = 7 * oneDay;
  static const int oneMonth = 30 * oneDay;

  String prettySinceDate(Locale locale) {
    final now = DateTime.now();
    final passed = now.millisecondsSinceEpoch - millisecondsSinceEpoch;
    if (passed < 2 * oneMinute) {
      return CommonLocalizer.justNow;
    } else if (passed < oneHour) {
      return "${CommonLocalizer.sinceDate} ${passed ~/ oneMinute} ${CommonLocalizer.minute}";
    } else if (passed < oneDay) {
      return "${CommonLocalizer.sinceDate} ${passed ~/ oneHour} ${CommonLocalizer.hour}";
    } else if (passed < oneWeek) {
      return "${CommonLocalizer.sinceDate} ${passed ~/ oneDay} ${CommonLocalizer.day}";
    } else if (passed < oneMonth) {
      return "${CommonLocalizer.sinceDate} ${passed ~/ oneWeek} ${CommonLocalizer.week}";
    } else {
      return DateFormat.yMd(locale.languageCode).format(this);
    }
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

extension ConvertTimeStampToDateTimes on int {
  DateTime mapToDateTimes() {
    return DateTime.fromMillisecondsSinceEpoch(this);
  }
}
