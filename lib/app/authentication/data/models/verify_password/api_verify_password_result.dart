import 'dart:convert';

ApiVerifyForgotPassword verifyForgotPasswordFromJson(String str) =>
    ApiVerifyForgotPassword.fromJson(json.decode(str));

String verifyForgotPasswordToJson(ApiVerifyForgotPassword data) =>
    json.encode(data.toJson());

class ApiVerifyForgotPassword {
  ApiVerifyForgotPassword({
    this.data,
  });

  ApiVerifyForgotPasswordData? data;

  factory ApiVerifyForgotPassword.fromJson(Map<String, dynamic> json) =>
      ApiVerifyForgotPassword(
        data: json["data"] == null
            ? null
            : ApiVerifyForgotPasswordData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class ApiVerifyForgotPasswordData {
  ApiVerifyForgotPasswordData({
    this.verifyForgetPasswordCode,
  });

  ApiVerifyForgetPasswordCode? verifyForgetPasswordCode;

  factory ApiVerifyForgotPasswordData.fromJson(Map<String, dynamic> json) =>
      ApiVerifyForgotPasswordData(
        verifyForgetPasswordCode: json["verifyForgetPasswordCode"] == null
            ? null
            : ApiVerifyForgetPasswordCode.fromJson(
                json["verifyForgetPasswordCode"]),
      );

  Map<String, dynamic> toJson() => {
        "verifyForgetPasswordCode": verifyForgetPasswordCode?.toJson(),
      };
}

class ApiVerifyForgetPasswordCode {
  ApiVerifyForgetPasswordCode({
    this.data,
    this.code,
    this.success,
    this.message,
  });

  bool? data;
  int? code;
  bool? success;
  String? message;

  factory ApiVerifyForgetPasswordCode.fromJson(Map<String, dynamic> json) =>
      ApiVerifyForgetPasswordCode(
        data: json["data"],
        code: json["code"],
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "code": code,
        "success": success,
        "message": message,
      };
}
