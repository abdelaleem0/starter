import 'dart:convert';

import 'package:starter/app/authentication/data/models/api_user_data.dart';

ApiSocialOtpVerificationResult apiSocialVerifyEmailResultFromJson(String str) =>
    ApiSocialOtpVerificationResult.fromJson(json.decode(str));

String apiSocialVerifyEmailResultToJson(ApiSocialOtpVerificationResult data) =>
    json.encode(data.toJson());

class ApiSocialOtpVerificationResult {
  ApiSocialVerifyEmail? verifyEmailOwnership;

  ApiSocialOtpVerificationResult({
    this.verifyEmailOwnership,
  });

  factory ApiSocialOtpVerificationResult.fromJson(Map<String, dynamic> json) =>
      ApiSocialOtpVerificationResult(
        verifyEmailOwnership: json["verifyEmailOwnership"] == null
            ? null
            : ApiSocialVerifyEmail.fromJson(json["verifyEmailOwnership"]),
      );

  Map<String, dynamic> toJson() => {
        "verifyEmailOwnership": verifyEmailOwnership?.toJson(),
      };
}

class ApiSocialVerifyEmail {
  ApiUserData? data;
  int? code;
  bool? success;
  String? message;

  ApiSocialVerifyEmail({
    this.data,
    this.code,
    this.success,
    this.message,
  });

  factory ApiSocialVerifyEmail.fromJson(Map<String, dynamic> json) =>
      ApiSocialVerifyEmail(
        data: json["data"] == null
            ? null
            : ApiUserData.fromJson(json["data"]),
        code: json["code"],
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "code": code,
        "success": success,
        "message": message,
      };
}

