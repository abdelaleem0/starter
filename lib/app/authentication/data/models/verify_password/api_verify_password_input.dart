import 'package:json_annotation/json_annotation.dart';
part 'api_verify_password_input.g.dart';

@JsonSerializable()
class ApiVerifyPasswordInput{
  final String code;
  final String email;

  ApiVerifyPasswordInput({
    required this.code,
    required this.email,
  });

  factory ApiVerifyPasswordInput.fromJson(Map<String, dynamic> json) =>
      _$ApiVerifyPasswordInputFromJson(json);

  Map<String, dynamic> toJson() => _$ApiVerifyPasswordInputToJson(this);

  Map<String, dynamic> toJsonWithoutNulls() {
    final Map<String, dynamic> filteredJson = {};
    toJson().forEach((key, value) {
      if (value != null) {
        filteredJson[key] = value;
      }
    });
    return filteredJson;
  }

  factory ApiVerifyPasswordInput.fromVerifyCodeInput(String code, String email) {
    return ApiVerifyPasswordInput(code: code, email: email);
  }


}