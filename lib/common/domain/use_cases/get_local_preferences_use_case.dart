import 'package:starter/common/domain/models/user_local_preferences.dart';
import 'package:starter/data/preferences/secure_storage/preferences_helper.dart';

class GetLocalPreferencesUseCase {
  final PreferencesHelper _preferencesHelper;

  GetLocalPreferencesUseCase(this._preferencesHelper);

  Future<UserLocalPreferences> execute() async {
    return (await _preferencesHelper.getUserLocalPreferences()).map();
  }
}
