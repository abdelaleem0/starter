import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/common/domain/models/otp.dart';
import 'package:starter/data/preferences/shared_preferences/shared_preferences_helper.dart';
import 'package:starter/di/app_injector.dart';

class SharedPreferencesHelperImp implements ShardPreferencesHelper {
  SharedPreferences? _sharedPreferences;

  Future<SharedPreferences> _getInstance() async {
    return _sharedPreferences ??= await injector.getAsync();
  }

  @override
  Future<String?> getLanguage() async {
    final instant = await _getInstance();
    return instant.getString(_PreferencesKeys.languageKey);
  }

  @override
  Future<bool> setLanguage(String language) async {
    final instant = await _getInstance();
    return await instant.setString(_PreferencesKeys.languageKey, language);
  }

  @override
  Future<String?> getVersion() async {
    final instant = await _getInstance();
    return instant.getString(_PreferencesKeys.versionKey);
  }

  @override
  Future<bool> setVersion(String version) async {
    final instant = await _getInstance();
    return await instant.setString(_PreferencesKeys.versionKey, version);
  }

  @override
  Future<void> deleteOTP() async {
    final instant = await _getInstance();
    await instant.remove(_PreferencesKeys.otp);
  }

  @override
  Future<OTP?> getOTP() async {
    final instant = await _getInstance();
    final otp = instant.getString(_PreferencesKeys.otp);
    if (otp == null) {
      return null;
    }
    final Map<String, dynamic> decode = json.decode(otp);
    return OTP(
      decode['numberOTPInHour'],
        DateTime.parse(decode['firstOTPTime']),
      decode['isBlocked'],
    );
  }

  @override
  Future<bool> setOTP(OTP otp) async {
    try {
      final instant = await _getInstance();
      Map<String, dynamic> otpObject = {
        'numberOTPInHour': otp.numberOTPInHour,
        'firstOTPTime': otp.firstOTPTime.toString(),
        'isBlocked': otp.isBlocked,
      };
      String encodedMap = json.encode(otpObject);
      return await instant.setString(_PreferencesKeys.otp, encodedMap);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> getIsFirstAppLaunch() async {
    final instance= await _getInstance();
    return instance.getBool(_PreferencesKeys.isFirstAppLaunch) ?? true;
  }

  @override
  Future<bool> setIsFirstAppLaunch(bool? isFirstAppLaunch) async {
    try
    {
      final instance= await _getInstance();
      return await instance.setBool(_PreferencesKeys.isFirstAppLaunch, isFirstAppLaunch??true);
    }catch(e)
    {
      throw Exception(e);
    }
  }
}

class _PreferencesKeys {
  _PreferencesKeys._();
  static const isFirstAppLaunch = "isFirstAppLaunch";
  static const languageKey = "languageKey";
  static const versionKey = "versionKey";
  static const otp = "otp";
}
