import 'dart:io' show Platform;

import 'package:starter/app/authentication/domain/models/inputs/login_details_input.dart';
import 'package:starter/common/domain/use_cases/fcm_token_use_case.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

class GetDeviceInfoUseCase {
  final FcmTokenUseCase _fcmTokenUseCase;
  GetDeviceInfoUseCase(this._fcmTokenUseCase);

  Future<LoginDetailsInput> execute() async {
    try {
  String fcmToken=   await _fcmTokenUseCase.execute();
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        String deviceName =
            '${androidInfo.manufacturer}/${androidInfo.brand}/${androidInfo.model}';
        return LoginDetailsInput(deviceName: deviceName,fcmToken: fcmToken);
      } else {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        String deviceName = '${iosInfo.model}/${iosInfo.name}';
        return LoginDetailsInput(deviceName: deviceName,fcmToken: fcmToken);
      }
    } on PlatformException {
      throw PlatformException(code: 'Failed to get platform version.');
    } catch (e) {
      throw Exception(e);
    }
  }
}
