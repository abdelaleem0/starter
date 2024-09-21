import 'package:starter/common/base/localization/app_localization.dart';
import 'package:flutter/material.dart';

class AuthenticationLocalization extends AppLocalizations {
  AuthenticationLocalization(super.locale);

  static const LocalizationsDelegate<AuthenticationLocalization> delegate =
      _AuthenticationLocalizationDelegate();

  @override
  String getLocalizationPath() {
    return 'i18n/authentication/auth_${locale.languageCode}.json';
  }
}

class _AuthenticationLocalizationDelegate
    extends AppLocalizationsDelegate<AuthenticationLocalization> {
  const _AuthenticationLocalizationDelegate();

  @override
  AuthenticationLocalization getInstance(Locale locale) {
    return AuthenticationLocalization(locale);
  }
}
