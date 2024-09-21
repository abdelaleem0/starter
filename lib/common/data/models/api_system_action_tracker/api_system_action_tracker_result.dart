import 'package:starter/common/data/models/api_void_message_response.dart';

class ApiSystemActionTrackerResult {
  final ApiVoidMessageResponse? incrementShares;

  ApiSystemActionTrackerResult({
    this.incrementShares,
  });

  factory ApiSystemActionTrackerResult.fromJson(Map<String, dynamic> json) =>
      ApiSystemActionTrackerResult(
        incrementShares: json["incrementShares"] == null
            ? null
            : ApiVoidMessageResponse.fromJson(json["incrementShares"]),
      );

  Map<String, dynamic> toJson() => {
    "incrementShares": incrementShares?.toJson(),
  };
}