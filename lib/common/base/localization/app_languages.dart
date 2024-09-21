
import 'package:flutter/material.dart';

class AppLanguages {
  AppLanguages._();

  static const ar = "ar";
  static const en = "en";

  static bool contains(Locale locale) {
    return [ar, en].contains(locale.languageCode);
  }

  static const List<Locale> supportedLocales = [
    Locale(ar),
    Locale(en)
  ];
}