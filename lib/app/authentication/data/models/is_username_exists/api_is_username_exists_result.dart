



class ApiApiIsUserExistsData {
  ApiApiIsUserExistsData({
    this.validateUsername,
  });

  ApiValidateUsername? validateUsername;

  factory ApiApiIsUserExistsData.fromJson(Map<String, dynamic> json) =>
      ApiApiIsUserExistsData(
        validateUsername: json["validateUsername"] == null
            ? null
            : ApiValidateUsername.fromJson(
                json["validateUsername"]),
      );

}

class ApiValidateUsername {
  ApiValidateUsername({
    this.data,
    this.code,
    this.success,
    this.message,
  });

  bool? data;
  int? code;
  bool? success;
  String? message;

  factory ApiValidateUsername.fromJson(Map<String, dynamic> json) =>
      ApiValidateUsername(
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
