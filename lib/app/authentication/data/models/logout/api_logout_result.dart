
// To parse this JSON data, do
//
//     final apiLogoutData = apiLogoutDataFromJson(jsonString);

import 'dart:convert';

ApiLogoutData apiLogoutDataFromJson(String str) => ApiLogoutData.fromJson(json.decode(str));

String apiLogoutDataToJson(ApiLogoutData data) => json.encode(data.toJson());

class ApiLogoutData {
  ApiLogoutData({
    this.logout,
  });

  Logout? logout;

  factory ApiLogoutData.fromJson(Map<String, dynamic> json) => ApiLogoutData(
    logout: json["logout"] == null ? null : Logout.fromJson(json["logout"]),
  );

  Map<String, dynamic> toJson() => {
    "logout": logout?.toJson(),
  };
}

class Logout {
  Logout({
    this.code,
    this.success,
    this.message,
  });

  int? code;
  bool? success;
  String? message;

  factory Logout.fromJson(Map<String, dynamic> json) => Logout(
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
