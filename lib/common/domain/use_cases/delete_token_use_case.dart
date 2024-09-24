import 'package:starter/data/preferences/secure_storage/preferences_helper.dart';

class DeleteCachedUserUseCase {
  final PreferencesHelper _preferences;

  DeleteCachedUserUseCase(this._preferences);

  Future<void> execute() async {
    return await _preferences.deleteUserData();
  }
}
