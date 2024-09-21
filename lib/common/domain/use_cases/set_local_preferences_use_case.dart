import 'package:starter/common/domain/inputs/local_preferences_input.dart';
import 'package:starter/common/domain/use_cases/get_local_preferences_use_case.dart';
import 'package:starter/data/preferences/models/local_preferences.dart';
import 'package:starter/data/preferences/preferences_helper.dart';

class SetLocalPreferencesUseCase {
  final PreferencesHelper _preferencesHelper;
  final GetLocalPreferencesUseCase _getLocalPreferencesUseCase;

  SetLocalPreferencesUseCase(
      this._preferencesHelper, this._getLocalPreferencesUseCase);

  Future<void> execute(LocalPreferencesInput input) async {
    final preferences = input
        .mergeWithUserPreferences(await _getLocalPreferencesUseCase.execute());
    await _preferencesHelper
        .setUserLocalPreferences(LocalPreferences.fromDomain(preferences));
  }
}
