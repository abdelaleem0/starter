
import 'package:starter/data/preferences/models/cached_user_data.dart';
import 'package:starter/data/preferences/preferences_helper.dart';

class GetCachedUserDataUseCase {
  final PreferencesHelper _preferencesHelper;

  GetCachedUserDataUseCase(this._preferencesHelper);

  Future<CachedUserData> execute() async {
    final result = await _preferencesHelper.getUserData();
    return result;
  }
}
