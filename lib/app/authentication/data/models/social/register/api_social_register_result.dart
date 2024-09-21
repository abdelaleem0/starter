import 'dart:convert';

import 'package:starter/app/authentication/data/models/api_user_data.dart';

ApiSocialRegisterResult apiSocialRegisterResultFromJson(String str) => ApiSocialRegisterResult.fromJson(json.decode(str));

String apiSocialRegisterResultToJson(ApiSocialRegisterResult data) => json.encode(data.toJson());

class ApiSocialRegisterResult {
  SocialRegister? socialRegister;

  ApiSocialRegisterResult({
    this.socialRegister,
  });

  factory ApiSocialRegisterResult.fromJson(Map<String, dynamic> json) => ApiSocialRegisterResult(
    socialRegister: json["socialRegister"] == null ? null : SocialRegister.fromJson(json["socialRegister"]),
  );

  Map<String, dynamic> toJson() => {
    "socialRegister": socialRegister?.toJson(),
  };
}

class SocialRegister {
  ApiUserData? data;
  int? code;
  bool? success;
  String? message;

  SocialRegister({
    this.data,
    this.code,
    this.success,
    this.message,
  });

  factory SocialRegister.fromJson(Map<String, dynamic> json) => SocialRegister(
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

