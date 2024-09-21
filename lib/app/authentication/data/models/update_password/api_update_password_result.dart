import 'dart:convert';

ApiUpdatePasswordResult apiUpdatePasswordResultFromJson(String str) => ApiUpdatePasswordResult.fromJson(json.decode(str));

String apiUpdatePasswordResultToJson(ApiUpdatePasswordResult data) => json.encode(data.toJson());

class ApiUpdatePasswordResult {
  ApiUpdatePasswordResult({
    this.resetPassword,
  });

  ApiResetPassword? resetPassword;

  factory ApiUpdatePasswordResult.fromJson(Map<String, dynamic> json) => ApiUpdatePasswordResult(
    resetPassword: json["resetPassword"] == null ? null : ApiResetPassword.fromJson(json["resetPassword"]),
  );

  Map<String, dynamic> toJson() => {
    "resetPassword": resetPassword?.toJson(),
  };
}

class ApiResetPassword {
  ApiResetPassword({
    this.data,
    this.code,
    this.success,
    this.message,
  });

  ApiResetPasswordData? data;
  int? code;
  bool? success;
  String? message;

  factory ApiResetPassword.fromJson(Map<String, dynamic> json) => ApiResetPassword(
    data: json["data"] == null ? null : ApiResetPasswordData.fromJson(json["data"]),
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

class ApiResetPasswordData {
  ApiResetPasswordData({
    this.verifiedEmail,
  });

  String? verifiedEmail;

  factory ApiResetPasswordData.fromJson(Map<String, dynamic> json) => ApiResetPasswordData(
    verifiedEmail: json["verifiedEmail"],
  );

  Map<String, dynamic> toJson() => {
    "verifiedEmail": verifiedEmail,
  };
}