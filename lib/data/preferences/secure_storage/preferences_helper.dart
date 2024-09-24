import 'package:starter/common/domain/models/token.dart';

import '../models/cached_user_data.dart';
import '../models/local_preferences.dart';

abstract class PreferencesHelper {
  Future<void> setId(String id);
  Future<String?> getId();

  Future<void> setToken(Token token);
  Future<Token?> getToken();
  Future<void> deleteToken();

  Future<void> setUserData(CachedUserData data);
  Future<void> setUserAppleEmail(String email);
  Future<String?> getUserAppleEmail();
  Future<void> deleteUserAppleEmail();
  Future<CachedUserData> getUserData();
  Future<void> deleteUserData();

  Future<void> setUserLocalPreferences(LocalPreferences preferences);
  Future<LocalPreferences> getUserLocalPreferences();
  Future<void> setBiometric(bool canUseBiometric);
  Future<String?> getBiometric();
  Future<void> deleteBiometric();
}
