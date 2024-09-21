import 'dart:convert';

ApiForgetPasswordResult apiMarkApprovalDialogueAsViewedResultFromJson(
        String str) =>
    ApiForgetPasswordResult.fromJson(json.decode(str));

String apiMarkApprovalDialogueAsViewedResultToJson(
        ApiForgetPasswordResult data) =>
    json.encode(data.toJson());

class ApiForgetPasswordResult {
  ApiForgetPasswordResult({
    this.forgetPassword,
  });

  ApiForgetPassword? forgetPassword;

  factory ApiForgetPasswordResult.fromJson(Map<String, dynamic> json) =>
      ApiForgetPasswordResult(
        forgetPassword: ApiForgetPassword.fromJson(json["forgetPassword"]),
      );

  Map<String, dynamic> toJson() => {
        "forgetPassword": forgetPassword?.toJson(),
      };
}

class ApiForgetPassword {
  ApiForgetPassword({
    this.data,
    this.message,
    this.code,
    this.success,
  });

  bool? data;
  String? message;
  int? code;
  bool? success;

  factory ApiForgetPassword.fromJson(Map<String, dynamic> json) =>
      ApiForgetPassword(
        data: json["data"],
        message: json["message"],
        code: json["code"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "message": message,
        "code": code,
        "success": success,
      };
}

