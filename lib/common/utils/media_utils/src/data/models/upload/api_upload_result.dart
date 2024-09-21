// To parse this JSON data, do
//
//     final uploadFileResult = uploadFileResultFromJson(jsonString);

import 'dart:convert';

ApiUploadFileResult uploadFileResultFromJson(String str) =>
    ApiUploadFileResult.fromJson(json.decode(str));

String uploadFileResultToJson(ApiUploadFileResult data) =>
    json.encode(data.toJson());

class ApiUploadFileResult {
  ApiUploadFileResult({
    this.uploadFile,
  });

  ApiUploadFileData? uploadFile;

  factory ApiUploadFileResult.fromJson(Map<String, dynamic> json) =>
      ApiUploadFileResult(
        uploadFile: json["uploadFile"] == null
            ? null
            : ApiUploadFileData.fromJson(json["uploadFile"]),
      );

  Map<String, dynamic> toJson() => {
        "uploadFile": uploadFile?.toJson(),
      };
}

class ApiUploadFileData {
  ApiUploadFileData({
    this.data,
    this.message,
    this.code,
    this.success,
  });

  String? data;
  String? message;
  int? code;
  bool? success;

  factory ApiUploadFileData.fromJson(Map<String, dynamic> json) => ApiUploadFileData(
        data: json["data"],
        message: json["message"],
        code: json["code"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "message": message,
        "code": code,
        "success": success,
      };
}
