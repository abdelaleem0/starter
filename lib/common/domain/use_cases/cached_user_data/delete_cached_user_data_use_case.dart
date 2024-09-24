
import 'package:starter/data/preferences/secure_storage/preferences_helper.dart';

class DeleteCachedUserDataUseCase {
  final PreferencesHelper _preferences;

  DeleteCachedUserDataUseCase(this._preferences);

  Future<void> execute() async {
    return await _preferences.deleteUserData();
  }
}
