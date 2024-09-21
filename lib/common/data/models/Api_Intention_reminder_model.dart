// To parse this JSON data, do
//
//     final apiIntentionReminder = apiIntentionReminderFromJson(jsonString);

import 'dart:convert';

ApiIntentionReminder apiIntentionReminderFromJson(String str) => ApiIntentionReminder.fromJson(json.decode(str));

String apiIntentionReminderToJson(ApiIntentionReminder data) => json.encode(data.toJson());

class ApiIntentionReminder {
  RandomIntention? randomIntention;

  ApiIntentionReminder({
    this.randomIntention,
  });

  factory ApiIntentionReminder.fromJson(Map<String, dynamic> json) => ApiIntentionReminder(
    randomIntention: json["randomIntention"] == null ? null : RandomIntention.fromJson(json["randomIntention"]),
  );

  Map<String, dynamic> toJson() => {
    "randomIntention": randomIntention?.toJson(),
  };
}

class RandomIntention {
  ApiRandomIntentionData? data;
  bool? success;
  int? code;
  String? message;

  RandomIntention({
    this.data,
    this.success,
    this.code,
    this.message,
  });

  factory RandomIntention.fromJson(Map<String, dynamic> json) => RandomIntention(
    data: json["data"] == null ? null : ApiRandomIntentionData.fromJson(json["data"]),
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

class ApiRandomIntentionData {
  String? id;
  String? code;
  String? enContent;
  String? arContent;
  String? enReference;
  String? arReference;

  ApiRandomIntentionData({
    this.id,
    this.code,
    this.enContent,
    this.arContent,
    this.enReference,
    this.arReference,
  });

  factory ApiRandomIntentionData.fromJson(Map<String, dynamic> json) => ApiRandomIntentionData(
    id: json["id"],
    code: json["code"],
    enContent: json["enContent"],
    arContent: json["arContent"],
    enReference: json["enReference"],
    arReference: json["arReference"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "enContent": enContent,
    "arContent": arContent,
    "enReference": enReference,
    "arReference": arReference,
  };
}
