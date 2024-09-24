import 'package:starter/data/preferences/secure_storage/preferences_helper.dart';

class SetCachedAppleEmailUseCase {
  final PreferencesHelper _secureStorage;

  SetCachedAppleEmailUseCase(this._secureStorage);

  Future<void> execute(String email) async {
    await _secureStorage.setUserAppleEmail(email);
  }
}

class GetCachedAppleEmailUseCase {
  final PreferencesHelper _secureStorage;

  GetCachedAppleEmailUseCase(this._secureStorage);

  Future<String?> execute() async {
    return await _secureStorage.getUserAppleEmail();
  }
}

class DeleteCachedAppleEmailUseCase {
  final PreferencesHelper _secureStorage;

  DeleteCachedAppleEmailUseCase(this._secureStorage);

  Future<void> execute() async {
    await _secureStorage.deleteUserAppleEmail();
  }
}