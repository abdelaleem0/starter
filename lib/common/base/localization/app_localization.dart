import 'dart:async';
import 'dart:convert';
import 'package:starter/di/app_injector.dart';
import 'package:starter/di/localizations_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_languages.dart';

abstract class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  Map<String, String> _localizedStrings = {};

  ///'i18n/${locale.languageCode}.json'
  String getLocalizationPath();

  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    String jsonString = await rootBundle.loadString(getLocalizationPath());
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}

abstract class AppLocalizationsDelegate<T extends AppLocalizations>
    extends LocalizationsDelegate<T> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const AppLocalizationsDelegate();

  T getInstance(Locale locale);

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return AppLanguages.contains(locale);
  }

  @override
  Future<T> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    final localizations = getInstance(locale);
    await localizations.load();
    _registerLocalizationsInDi(localizations);
    return localizations;
  }

  void _registerLocalizationsInDi(T localizations) async {
    final container = injector.get<LocalizationsContainer>();
    container.registerLocalizations(localizations);
  }

  @override
  bool shouldReload(LocalizationsDelegate<T> old) => false;
}
