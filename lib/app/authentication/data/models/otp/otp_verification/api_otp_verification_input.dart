import 'package:starter/app/authentication/domain/models/otp_verification/otp_verification/otp_verification_input.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_otp_verification_input.g.dart';

@JsonSerializable()
class ApiOtpVerificationInput {
  final String email;
  final String verificationCode;

  factory ApiOtpVerificationInput.fromJson(Map<String, dynamic> json) =>
      _$ApiOtpVerificationInputFromJson(json);

  ApiOtpVerificationInput(this.email, this.verificationCode);

  Map<String, dynamic> toJson() => _$ApiOtpVerificationInputToJson(this);

  factory ApiOtpVerificationInput.fromInput(OtpVerificationInput input) {
    return ApiOtpVerificationInput(input.email, input.verificationCode);
  }
}
