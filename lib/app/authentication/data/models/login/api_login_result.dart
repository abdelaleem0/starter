// To parse this JSON data, do
//
//     final apiLoginConsultantResult = apiLoginConsultantResultFromJson(jsonString);

import 'dart:convert';

import 'package:starter/app/authentication/data/models/api_user_data.dart';

ApiLoginResult apiLoginConsultantResultFromJson(String str) =>
    ApiLoginResult.fromJson(json.decode(str));

String apiLoginResultToJson(ApiLoginResult data) =>
    json.encode(data.toJson());

class ApiLoginResult {
  ApiLoginResult({
    this.registerOrlogin,
  });

  ApiRegisterOrlogin? registerOrlogin;

  factory ApiLoginResult.fromJson(Map<String, dynamic> json) =>
      ApiLoginResult(
        registerOrlogin: json["emailAndPasswordLogin"] == null ? null :ApiRegisterOrlogin.fromJson(
            json["emailAndPasswordLogin"]),
      );

  Map<String, dynamic> toJson() => {
        "emailAndPasswordLogin": registerOrlogin?.toJson(),
      };
}

class ApiRegisterOrlogin {
  ApiRegisterOrlogin({
    this.data,
    this.code,
    this.success,
    this.message,
  });

  ApiUserData? data;
  int? code;
  bool? success;
  String? message;

  factory ApiRegisterOrlogin.fromJson(Map<String, dynamic> json) =>
      ApiRegisterOrlogin(
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

