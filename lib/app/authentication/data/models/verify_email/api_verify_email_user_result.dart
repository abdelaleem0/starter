import 'dart:convert';

import 'package:starter/app/authentication/data/models/api_user_data.dart';

ApiVerifyEmailUser welcomeFromJson(String str) => ApiVerifyEmailUser.fromJson(json.decode(str));

String welcomeToJson(ApiVerifyEmailUser data) => json.encode(data.toJson());

class ApiVerifyEmailUser {
  ApiVerifyEmailUser({
    this.data,
  });

  ApiVerifyEmailUserData? data;

  factory ApiVerifyEmailUser.fromJson(Map<String, dynamic> json) => ApiVerifyEmailUser(
    data: json["data"] == null ? null : ApiVerifyEmailUserData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class ApiVerifyEmailUserData {
  ApiVerifyEmailUserData({
    this.verifyUserByEmail,
  });

  ApiVerifyUserByEmail? verifyUserByEmail;

  factory ApiVerifyEmailUserData.fromJson(Map<String, dynamic> json) => ApiVerifyEmailUserData(
    verifyUserByEmail: json["verifyUserByEmail"] == null ? null : ApiVerifyUserByEmail.fromJson(json["verifyUserByEmail"]),
  );

  Map<String, dynamic> toJson() => {
    "verifyUserByEmail": verifyUserByEmail?.toJson(),
  };
}

class ApiVerifyUserByEmail {
  ApiVerifyUserByEmail({
    this.data,
    this.code,
    this.success,
    this.message,
  });

  ApiUserData? data;
  int? code;
  bool? success;
  String? message;

  factory ApiVerifyUserByEmail.fromJson(Map<String, dynamic> json) => ApiVerifyUserByEmail(
    data: json["data"] == null ? null : ApiUserData.fromJson(json["data"]),
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

