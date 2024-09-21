import 'package:json_annotation/json_annotation.dart';
part 'api_verify_email_user.g.dart';

@JsonSerializable()
class ApiVerifyEmailUserInput {
  final String verificationCode;
  final String email;

  ApiVerifyEmailUserInput({
    required this.verificationCode,
    required this.email,
  });

  factory ApiVerifyEmailUserInput.fromJson(Map<String, dynamic> json) =>
      _$ApiVerifyEmailUserInputFromJson(json);

  Map<String, dynamic> toJson() => _$ApiVerifyEmailUserInputToJson(this);

  Map<String, dynamic> toJsonWithoutNulls() {
    final Map<String, dynamic> filteredJson = {};
    toJson().forEach((key, value) {
      if (value != null) {
        filteredJson[key] = value;
      }
    });
    return filteredJson;
  }

  factory ApiVerifyEmailUserInput.fromVerifyCodeInput(
      {required String verificationCode, required String email}) {
    return ApiVerifyEmailUserInput(verificationCode: verificationCode, email: email);
  }
}


