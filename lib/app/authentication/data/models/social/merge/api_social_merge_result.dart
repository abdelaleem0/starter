// To parse this JSON data, do
//
//     final apiSocialMergeResult = apiSocialMergeResultFromJson(jsonString);

import 'dart:convert';

import 'package:starter/app/authentication/data/models/api_user_data.dart';

ApiSocialMergeResult apiSocialMergeResultFromJson(String str) =>
    ApiSocialMergeResult.fromJson(json.decode(str));

String apiSocialMergeResultToJson(ApiSocialMergeResult data) =>
    json.encode(data.toJson());

class ApiSocialMergeResult {
  ApiSocialMerge? socialMerge;

  ApiSocialMergeResult({
    this.socialMerge,
  });

  factory ApiSocialMergeResult.fromJson(Map<String, dynamic> json) =>
      ApiSocialMergeResult(
        socialMerge: json["socialMerge"] == null
            ? null
            : ApiSocialMerge.fromJson(json["socialMerge"]),
      );

  Map<String, dynamic> toJson() => {
        "socialMerge": socialMerge?.toJson(),
      };
}

class ApiSocialMerge {
  ApiUserData? data;
  int? code;
  String? message;

  ApiSocialMerge({
    this.data,
    this.code,
    this.message,
  });

  factory ApiSocialMerge.fromJson(Map<String, dynamic> json) => ApiSocialMerge(
        data: json["data"] == null ? null : ApiUserData.fromJson(json["data"]),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "code": code,
        "message": message,
      };
}

