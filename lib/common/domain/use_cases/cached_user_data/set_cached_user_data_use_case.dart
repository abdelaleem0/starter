import 'package:starter/data/preferences/models/cached_user_data.dart';

import '../../../../data/preferences/secure_storage/preferences_helper.dart';

class SetCachedUserDataUseCase {
  final PreferencesHelper _preferencesHelper;

  SetCachedUserDataUseCase(this._preferencesHelper);

  Future<void> call(CachedUserData userData) async {
    await _preferencesHelper.setUserData(userData);
  }
}
