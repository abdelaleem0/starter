import 'package:starter/data/preferences/preferences_helper.dart';

class UserAuthenticatedUseCase {
  final PreferencesHelper _preferencesHelper;

  UserAuthenticatedUseCase(this._preferencesHelper);

  Future<bool> execute() async {
    final token = await _preferencesHelper.getToken();
    if ((token?.token.isNotEmpty ?? false)) {
      if (token?.isCompleteRegister == true) {
        return true;
      } else {
        await _preferencesHelper.deleteUserData();
        return false;
      }
    }
    return false;
  }
}
