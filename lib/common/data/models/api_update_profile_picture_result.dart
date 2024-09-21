import 'package:starter/app/authentication/data/models/api_user_data.dart';

class ApiUpdateProfilePictureResult {
  final UpdateProfilePicture? updateProfilePicture;

  ApiUpdateProfilePictureResult({
    this.updateProfilePicture,
  });

  factory ApiUpdateProfilePictureResult.fromJson(Map<String, dynamic> json) => ApiUpdateProfilePictureResult(
    updateProfilePicture: json["updateProfilePicture"] == null ? null : UpdateProfilePicture.fromJson(json["updateProfilePicture"]),
  );

  Map<String, dynamic> toJson() => {
    "updateProfilePicture": updateProfilePicture?.toJson(),
  };
}

class UpdateProfilePicture {
  final ApiUserData? data;
  final bool? success;
  final int? code;
  final String? message;

  UpdateProfilePicture({
    this.data,
    this.success,
    this.code,
    this.message,
  });

  factory UpdateProfilePicture.fromJson(Map<String, dynamic> json) => UpdateProfilePicture(
    data: json["data"] == null ? null : ApiUserData.fromJson(json["data"]),
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

