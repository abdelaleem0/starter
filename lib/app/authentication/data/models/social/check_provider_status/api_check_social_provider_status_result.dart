// To parse this JSON data, do
//
//     final apiSocialCheckProviderStatusResult = apiSocialCheckProviderStatusResultFromJson(jsonString);

import 'dart:convert';

import 'package:starter/app/authentication/data/models/api_user_data.dart';

ApiSocialCheckProviderStatusResult apiSocialCheckProviderStatusResultFromJson(String str) => ApiSocialCheckProviderStatusResult.fromJson(json.decode(str));

String apiSocialCheckProviderStatusResultToJson(ApiSocialCheckProviderStatusResult data) => json.encode(data.toJson());

class ApiSocialCheckProviderStatusResult {
  CheckSocialProviderStatus? checkSocialProviderStatus;

  ApiSocialCheckProviderStatusResult({
    this.checkSocialProviderStatus,
  });

  factory ApiSocialCheckProviderStatusResult.fromJson(Map<String, dynamic> json) => ApiSocialCheckProviderStatusResult(
    checkSocialProviderStatus: json["checkSocialProviderStatus"] == null ? null : CheckSocialProviderStatus.fromJson(json["checkSocialProviderStatus"]),
  );

  Map<String, dynamic> toJson() => {
    "checkSocialProviderStatus": checkSocialProviderStatus?.toJson(),
  };
}

class CheckSocialProviderStatus {
  CheckSocialProviderStatusData? data;
  bool? success;
  int? code;
  String? message;

  CheckSocialProviderStatus({
    this.data,
    this.success,
    this.code,
    this.message,
  });

  factory CheckSocialProviderStatus.fromJson(Map<String, dynamic> json) => CheckSocialProviderStatus(
    data: json["data"] == null ? null : CheckSocialProviderStatusData.fromJson(json["data"]),
    success: json["success"],
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "success": success,
    "code": code,
    "message": message,
  };
}

class CheckSocialProviderStatusData {
  String? actionRequired;
  ApiUserData? user;

  CheckSocialProviderStatusData({
    this.actionRequired,
    this.user,
  });

  factory CheckSocialProviderStatusData.fromJson(Map<String, dynamic> json) => CheckSocialProviderStatusData(
    actionRequired: json["actionRequired"],
    user: json["user"] == null ? null : ApiUserData.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "actionRequired": actionRequired,
    "user": user?.toJson(),
  };
}

