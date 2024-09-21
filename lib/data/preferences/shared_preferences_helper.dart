import 'package:starter/common/domain/models/otp.dart';

abstract class ShardPreferencesHelper {
  Future<bool> setLanguage(String language);

  Future<String?> getLanguage();

  Future<bool> setVersion(String version);

  Future<String?> getVersion();


  Future<bool> setOTP(OTP otp);

  Future<void> deleteOTP();

  Future<OTP?> getOTP();

  Future<bool> setIsFirstAppLaunch(bool isFirstAppLaunch);

  Future<bool> getIsFirstAppLaunch();
}
