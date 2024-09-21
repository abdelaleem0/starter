import 'dart:io';
import 'package:starter/common/base/localization/app_localization.dart';
import 'app_injector.dart';

class LocalizationsContainer {
  bool isArabic = true;

  final List<AppLocalizations> _localizationsList = [];
  void registerLocalizations<T extends AppLocalizations>(T localizations) {
    final item = _getItemOfType<T>();

    if (item != null) {
      _localizationsList.removeWhere((element) => element is T);
    }

    isArabic = localizations.locale.languageCode.contains('ar');

    _localizationsList.add(localizations);
  }

  T getLocalizations<T extends AppLocalizations>() {
    return _localizationsList.firstWhere((element) => element is T) as T;
  }

  T? _getItemOfType<T>() {
    try {
      return _localizationsList.firstWhere((element) => element is T) as T?;
    } catch (e) {
      return null;
    }
  }
}

bool isAppInArabic() {
  try {
    return injector.get<LocalizationsContainer>().isArabic;
  } catch (e) {
    return Platform.localeName.contains('ar');
  }
}
