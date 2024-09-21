import 'package:flutter/material.dart';
import 'package:starter/common/base/localization/app_localization.dart';

class CommonLocalization extends AppLocalizations {
  CommonLocalization(super.locale);

  static const LocalizationsDelegate<CommonLocalization> delegate =
      _CommonLocalizationDelegate();

  @override
  String getLocalizationPath() {
    return 'i18n/common/common_${locale.languageCode}.json';
  }
}

class _CommonLocalizationDelegate
    extends AppLocalizationsDelegate<CommonLocalization> {
  const _CommonLocalizationDelegate();

  @override
  CommonLocalization getInstance(Locale locale) {
    return CommonLocalization(locale);
  }
}
