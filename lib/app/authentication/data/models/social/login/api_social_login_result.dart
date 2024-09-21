// To parse this JSON data, do
//
//     final apiSocialLoginResult = apiSocialLoginResultFromJson(jsonString);

import 'dart:convert';

import 'package:starter/app/authentication/data/models/api_user_data.dart';

ApiSocialLoginResult apiSocialLoginResultFromJson(String str) => ApiSocialLoginResult.fromJson(json.decode(str));

String apiSocialLoginResultToJson(ApiSocialLoginResult data) => json.encode(data.toJson());

class ApiSocialLoginResult {
  ApiSocialLogin? socialLogin;

  ApiSocialLoginResult({
    this.socialLogin,
  });

  factory ApiSocialLoginResult.fromJson(Map<String, dynamic> json) => ApiSocialLoginResult(
    socialLogin: json["socialLogin"] == null ? null : ApiSocialLogin.fromJson(json["socialLogin"]),
  );

  Map<String, dynamic> toJson() => {
    "socialLogin": socialLogin?.toJson(),
  };
}

class ApiSocialLogin {
  ApiUserData? socialLoginData;
  int? code;
  bool? success;
  String? message;

  ApiSocialLogin({
    this.socialLoginData,
    this.code,
    this.success,
    this.message,
  });

  factory ApiSocialLogin.fromJson(Map<String, dynamic> json) => ApiSocialLogin(
    socialLoginData: json["data"] == null ? null : ApiUserData.fromJson(json["data"]),
    code: json["code"],
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": socialLoginData?.toJson(),
    "code": code,
    "success": success,
    "message": message,
  };
}
