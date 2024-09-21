import 'dart:convert';

ApiEmailExists welcomeFromJson(String str) => ApiEmailExists.fromJson(json.decode(str));

String welcomeToJson(ApiEmailExists data) => json.encode(data.toJson());

class ApiEmailExists {
  ApiEmailExists({
    this.data,
  });

  ApiEmailExistsData? data;

  factory ApiEmailExists.fromJson(Map<String, dynamic> json) => ApiEmailExists(
    data: ApiEmailExistsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class ApiEmailExistsData {
  ApiEmailExistsData({
    this.doesVerifiedEmailExist,
  });

  DoesVerifiedEmailExist? doesVerifiedEmailExist;

  factory ApiEmailExistsData.fromJson(Map<String, dynamic> json) => ApiEmailExistsData(
    doesVerifiedEmailExist: DoesVerifiedEmailExist.fromJson(json["doesVerifiedEmailExist"]),
  );

  Map<String, dynamic> toJson() => {
    "doesVerifiedEmailExist": doesVerifiedEmailExist?.toJson(),
  };
}

class DoesVerifiedEmailExist {
  DoesVerifiedEmailExist({
    this.data,
    this.code,
    this.success,
    this.message,
  });

  bool? data;
  int? code;
  bool? success;
  String? message;

  factory DoesVerifiedEmailExist.fromJson(Map<String, dynamic> json) => DoesVerifiedEmailExist(
    data: json["data"],
    code: json["code"],
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "code": code,
    "success": success,
    "message": message,
  };
}