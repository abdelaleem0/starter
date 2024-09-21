
import 'package:starter/common/domain/models/token.dart';
import 'package:starter/data/preferences/preferences_helper.dart';

class GetTokenUseCase {
  final PreferencesHelper _preferencesHelper;

  GetTokenUseCase(this._preferencesHelper);
  Future<Token?> execute() async {
    return await _preferencesHelper.getToken();
  }
}
