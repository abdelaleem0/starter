import 'package:starter/app/authentication/data/models/register/api_register_input.dart';
import 'package:starter/app/authentication/domain/models/inputs/complete_register_input.dart';
import 'package:json_annotation/json_annotation.dart';

part "api_complete_register_input.g.dart";

@JsonSerializable()
class ApiCompleteRegisterInput {
  final String firstName;
  final String userName;
  final String? fcmToken;
  final ApiDeviceEnum device;
  final String? profilePicture;

  ApiCompleteRegisterInput({
    required this.firstName,
    required this.userName,
    required this.fcmToken,
    required this.device,
    required this.profilePicture,
  });

  factory ApiCompleteRegisterInput.fromJson(Map<String, dynamic> json) =>
      _$ApiCompleteRegisterInputFromJson(json);

  Map<String, dynamic> toJson() => _$ApiCompleteRegisterInputToJson(this);

  Map<String, dynamic> toJsonWithoutNulls() {
    final Map<String, dynamic> filteredJson = {};
    toJson().forEach((key, value) {
      if (value != null) {
        filteredJson[key] = value;
      }
    });
    return filteredJson;
  }

  factory ApiCompleteRegisterInput.fromCompleteRegisterInput(
    CompleteRegisterInput completeRegisterInput,
  ) {
    final ApiDeviceEnum deviceEnum = getDeviceType();
    return ApiCompleteRegisterInput(
      userName: completeRegisterInput.userName ?? "",
      fcmToken: completeRegisterInput.fcmToken,
      firstName: completeRegisterInput.firstName ?? "",
      device: deviceEnum,
      profilePicture: completeRegisterInput.profilePicture?.url,
    );
  }
}
