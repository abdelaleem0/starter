import 'dart:async';
import 'dart:io';

import 'package:starter/data/preferences/shared_preferences_helper.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/app_injector.dart';
import '../../base/localization/app_languages.dart';
import 'app_language_event.dart';
import 'app_language_state.dart';

class AppLanguageBloc extends Bloc<AppLanguageEvent, AppLanguageState> {
  final ShardPreferencesHelper _shardPreferencesHelper;

  static AppLanguageBloc of(BuildContext context) {
    return BlocProvider.of(context);
  }

  AppLanguageBloc(this._shardPreferencesHelper)
      : super(const AppLanguageState.initial()) {
    on<AppLanguageAppStarted>(fetchCurrentLanguage);
    on<ChangeAppLanguage>(changeLanguage);
    _setLanguage();
  }

  void fetchCurrentLanguage(
      AppLanguageEvent event,
      Emitter<AppLanguageState> emit,
      ) async {
    final lang =
        (await getCurrentSelectedLanguage())
            ?? 'en';
    //?? (await getDeviceLanguage());
    await streamLanguageState(event, emit, lang);
  }

  Future<String?> getCurrentSelectedLanguage() async {
    return _shardPreferencesHelper.getLanguage();
  }

  Future<void> _setLanguage() async {
    final langInPreference = await getCurrentSelectedLanguage();
    if (langInPreference == null) {
      // if you want to save the initialLanguage from the device call this
      //  final lang = (await getDeviceLanguage())?.split('_').first;
      //  await _shardPreferencesHelper.setLanguage(lang ?? '');
      // if you want to save the initialLanguage to specific language  call this
      await _shardPreferencesHelper.setLanguage('en');

    }
  }

  Future<String?> getDeviceLanguage() async {
    return Platform.localeName;
  }

  Future<void> changeLanguage(
      ChangeAppLanguage event, Emitter<AppLanguageState> emit) async {
    await _shardPreferencesHelper
        .setLanguage(event.selectedLocale.languageCode);
    await streamLanguageState(event, emit, event.selectedLocale.languageCode);
  }

  Future<void> streamLanguageState(AppLanguageEvent event,
      Emitter<AppLanguageState> emit, String? lang) async {
    final deviceCountryCode = (await Devicelocale.currentAsLocale)?.countryCode;
    final language = lang?.split('_').first ?? AppLanguages.ar;
    emit(state.reduce(locale: Locale(language, deviceCountryCode)));
    // if (language == AppLanguages.en) {
    //   yield AppEnglishLanguage(Locale("en", deviceCountryCode));
    // } else {
    //   yield AppArabicLanguage(Locale("ar", deviceCountryCode));
    // }
    await resetScopeDependencies();
  }
}
