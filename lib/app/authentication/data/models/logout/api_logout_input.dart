
import 'package:starter/app/authentication/data/models/login/api_login_input.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_logout_input.g.dart';

@JsonSerializable()
class ApiLogoutInput {
  final DeviceEnum device;

  ApiLogoutInput(this.device);

  factory ApiLogoutInput.fromJson(Map<String, dynamic> json) => _$ApiLogoutInputFromJson(json);

  Map<String, dynamic> toJson() => _$ApiLogoutInputToJson(this);
}