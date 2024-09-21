import 'package:starter/common/data/models/api_void_message_response.dart';

class ApiIncrementPathsResult {
  final ApiVoidMessageResponse? incrementPathViews;

  ApiIncrementPathsResult({
    this.incrementPathViews,
  });

  factory ApiIncrementPathsResult.fromJson(Map<String, dynamic> json) =>
      ApiIncrementPathsResult(
        incrementPathViews: json["incrementPathViews"] == null
            ? null
            : ApiVoidMessageResponse.fromJson(json["incrementPathViews"]),
      );

  Map<String, dynamic> toJson() => {
    "incrementPathViews": incrementPathViews?.toJson(),
  };
}