class ApiVoidMessageResponse {
  final ApiVoidMessage? data;
  final bool? success;
  final int? code;
  final String? message;

  ApiVoidMessageResponse({
    this.data,
    this.success,
    this.code,
    this.message,
  });

  factory ApiVoidMessageResponse.fromJson(Map<String, dynamic> json) {
    return ApiVoidMessageResponse(
      data: json['data'] != null
          ? ApiVoidMessage.fromJson(json['data'])
          : null,
      success: json['success'],
      code: json['code'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'success': success,
      'code': code,
      'message': message,
    };
  }
}
class ApiVoidMessage{
  final String? voidableMessage;

  ApiVoidMessage({
    this.voidableMessage,
  });

  factory ApiVoidMessage.fromJson(Map<String, dynamic> json) => ApiVoidMessage(
    voidableMessage: json["voidableMessage"],
  );

  Map<String, dynamic> toJson() => {
    "voidableMessage": voidableMessage,
  };
}