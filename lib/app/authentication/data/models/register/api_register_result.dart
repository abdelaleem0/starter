// To parse this JSON data, do
//
//     final apiRegisterResult = apiRegisterResultFromJson(jsonString);

import 'dart:convert';

import 'package:starter/app/authentication/data/models/api_user_data.dart';

ApiRegisterResult apiRegisterResultFromJson(String str) =>
    ApiRegisterResult.fromJson(json.decode(str));

String apiRegisterResultToJson(ApiRegisterResult data) =>
    json.encode(data.toJson());

class ApiRegisterResult {
  ApiRegisterResult({
    this.completeRegister,
  });

  ApiCompleteRegister? completeRegister;

  factory ApiRegisterResult.fromJson(Map<String, dynamic> json) =>
      ApiRegisterResult(
        completeRegister: json["register"] == null
            ? null
            : ApiCompleteRegister?.fromJson(json["register"]),
      );

  Map<String, dynamic> toJson() => {
        "register":
            completeRegister?.toJson(),
      };
}

class ApiCompleteRegister {
  ApiCompleteRegister({
    this.data,
    this.code,
    this.success,
    this.message,
  });

  ApiUserData? data;
  int? code;
  bool? success;
  String? message;

  factory ApiCompleteRegister.fromJson(Map<String, dynamic> json) =>
      ApiCompleteRegister(
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

