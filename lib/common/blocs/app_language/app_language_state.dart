import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppLanguageState extends Equatable {
  final Locale locale;

  const AppLanguageState(this.locale);

  const AppLanguageState.initial()
      : this(
    const Locale("ar"),
  );

  AppLanguageState reduce({
    Locale? locale,
  }) {
    return AppLanguageState(
      locale ?? this.locale,
    );
  }

  @override
  List<Object> get props => [locale];
}

// class NonSpecifiedLanguage extends AppLanguageState {
//   const NonSpecifiedLanguage(Locale locale) : super(locale);
// }

// class AppArabicLanguage extends AppLanguageState {
//   const AppArabicLanguage(Locale locale) : super(locale);
// }
//
// class AppEnglishLanguage extends AppLanguageState {
//   const AppEnglishLanguage(Locale locale) : super(locale);
// }
