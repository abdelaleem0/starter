// To parse this JSON data, do
//
//     final apiResendEmailVerificationCode = apiResendEmailVerificationCodeFromJson(jsonString);

import 'dart:convert';

ApiResendEmailVerificationCode apiResendEmailVerificationCodeFromJson(String str) => ApiResendEmailVerificationCode.fromJson(json.decode(str));

String apiResendEmailVerificationCodeToJson(ApiResendEmailVerificationCode data) => json.encode(data.toJson());

class ApiResendEmailVerificationCode {
  ApiResendEmailVerificationCode({
    this.resendEmailVerificationCode,
  });

  ResendEmailVerificationCode? resendEmailVerificationCode;

  factory ApiResendEmailVerificationCode.fromJson(Map<String, dynamic> json) => ApiResendEmailVerificationCode(
    resendEmailVerificationCode: json["resendEmailVerificationCode"] == null ? null : ResendEmailVerificationCode.fromJson(json["resendEmailVerificationCode"]),
  );

  Map<String, dynamic> toJson() => {
    "resendEmailVerificationCode": resendEmailVerificationCode?.toJson(),
  };
}

class ResendEmailVerificationCode {
  ResendEmailVerificationCode({
    this.message,
    this.code,
    this.data,
  });

  String? message;
  int? code;
  bool? data;

  factory ResendEmailVerificationCode.fromJson(Map<String, dynamic> json) => ResendEmailVerificationCode(
    message: json["message"],
    code: json["code"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": data,
  };
}
