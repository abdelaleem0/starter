import 'package:starter/common/domain/models/otp.dart';

abstract class OTPRepository{
  Future<void> setOTP(OTP otp);
  Future<OTP?> getOTP();
  Future<void> deleteOTP();
}