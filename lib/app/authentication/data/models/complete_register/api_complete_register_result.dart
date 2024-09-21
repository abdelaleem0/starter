import 'dart:convert';

import 'package:starter/app/authentication/data/models/api_user_data.dart';

ApiCompleteRegisterResult apiCompleteRegisterResultFromJson(String str) => ApiCompleteRegisterResult.fromJson(json.decode(str));

String apiCompleteRegisterResultToJson(ApiCompleteRegisterResult data) => json.encode(data.toJson());

class ApiCompleteRegisterResult {
  ApiCompleteRegisterResult({
    this.completeUserRegister,
  });

  CompleteUserRegister? completeUserRegister;

  factory ApiCompleteRegisterResult.fromJson(Map<String, dynamic> json) => ApiCompleteRegisterResult(
    completeUserRegister: json["completeUserRegister"] == null ? null : CompleteUserRegister.fromJson(json["completeUserRegister"]),
  );

  Map<String, dynamic> toJson() => {
    "completeUserRegister": completeUserRegister?.toJson(),
  };
}

class CompleteUserRegister {
  CompleteUserRegister({
    this.data,
    this.code,
    this.success,
    this.message,
  });

  ApiUserData? data;
  int? code;
  bool? success;
  String? message;

  factory CompleteUserRegister.fromJson(Map<String, dynamic> json) => CompleteUserRegister(
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

