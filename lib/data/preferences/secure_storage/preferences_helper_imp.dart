import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:starter/common/domain/models/token.dart';
import '../models/cached_user_data.dart';
import '../models/local_preferences.dart';
import 'preferences_helper.dart';

class PreferencesHelperImp implements PreferencesHelper {
  final FlutterSecureStorage _storage;

  PreferencesHelperImp(this._storage);

  @override
  Future<void> setId(String id) {
    return _storage.write(key: _PreferencesKeys.idKey, value: id);
  }

  @override
  Future<String?> getId() {
    return _storage.read(key: _PreferencesKeys.idKey);
  }

  @override
  Future<void> setBiometric(bool canUseBiometric) {
    return _storage.write(key: _PreferencesKeys.biometricKey, value: canUseBiometric.toString());
  }

  @override
  Future<String?> getBiometric() {
    return _storage.read(key: _PreferencesKeys.biometricKey);
  }
  @override
  Future<void> deleteBiometric() async {
    await _storage.delete(key: _PreferencesKeys.biometricKey);
  }

  @override
  Future<void> setToken(Token token) async {
    Map<String, dynamic> tokenMap = {
      'token': token.token,
      'inCompleteRegister': token.isCompleteRegister,
    };
    String encodedMap = json.encode(tokenMap);
    return await _storage.write(
        key: _PreferencesKeys.tokenKey, value: encodedMap);
  }



  @override
  Future<Token?> getToken() async {
    try {
      final token = await _storage.read(key: _PreferencesKeys.tokenKey);
      if (token == null || token.isEmpty) {
        return null;
      }
      final Map<String, dynamic> decode = json.decode(token);
      return Token(
        decode['token'],
        decode['inCompleteRegister'],
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteToken() async {
    await _storage.delete(key: _PreferencesKeys.tokenKey);
  }

  @override
  Future<void> deleteUserData() async {
    await _storage.delete(key: _PreferencesKeys.idKey);
    await _storage.delete(key: _PreferencesKeys.userNameKey);
    await _storage.delete(key: _PreferencesKeys.profilePictureKey);
    await _storage.delete(key: _PreferencesKeys.tokenKey);

  }

  @override
  Future<CachedUserData> getUserData() async {
    return CachedUserData(
       id: await getId() ?? "", token: await getToken() ?? const Token('', false),
    );
  }

  @override
  Future<void> setUserData(CachedUserData data) async {
    await setId(data.id);
    await setToken(data.token);
  }

  @override
  Future<LocalPreferences> getUserLocalPreferences() async {
    return LocalPreferences();
  }

  @override
  Future<void> setUserLocalPreferences(LocalPreferences preferences) async {}

  @override
  Future<void> setUserAppleEmail(String email) async {
    return await _storage.write(key: _PreferencesKeys.appleEmail, value: email);
  }
  @override
  Future<String?> getUserAppleEmail() async {
    return await _storage.read(key: _PreferencesKeys.appleEmail);
  }
  @override
  Future<void> deleteUserAppleEmail() async {
    await _storage.delete(key: _PreferencesKeys.appleEmail);
  }
}

class _PreferencesKeys {
  _PreferencesKeys._();

  static const tokenKey = "tokenKey";
  static const idKey = "idKey";
  static const userNameKey = 'userNameKey';
  static const profilePictureKey = 'profilePictureKey';
  static const biometricKey = 'biometricKey';
  static const appleEmail = 'apple_email';
}
