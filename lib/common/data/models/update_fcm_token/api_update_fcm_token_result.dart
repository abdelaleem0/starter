// To parse this JSON data, do
//
//     final updateFcmTokenResult = updateFcmTokenResultFromJson(jsonString);

import 'dart:convert';

UpdateFcmTokenResult updateFcmTokenResultFromJson(String str) => UpdateFcmTokenResult.fromJson(json.decode(str));

String updateFcmTokenResultToJson(UpdateFcmTokenResult data) => json.encode(data.toJson());

class UpdateFcmTokenResult {
  UpdateFcmTokenResult({
    this.updateFcmToken,
  });

  UpdateFcmToken? updateFcmToken;

  factory UpdateFcmTokenResult.fromJson(Map<String, dynamic> json) => UpdateFcmTokenResult(
    updateFcmToken: json["updateFcmToken"] == null ? null : UpdateFcmToken.fromJson(json["updateFcmToken"]),
  );

  Map<String, dynamic> toJson() => {
    "updateFcmToken": updateFcmToken?.toJson(),
  };
}

class UpdateFcmToken {
  UpdateFcmToken({
    this.code,
    this.success,
    this.message,
  });

  int? code;
  bool? success;
  String? message;

  factory UpdateFcmToken.fromJson(Map<String, dynamic> json) => UpdateFcmToken(
    code: json["code"],
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "message": message,
  };
}
