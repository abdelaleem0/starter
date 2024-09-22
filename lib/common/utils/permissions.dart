import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissions {
  AppPermissions._();

  static final instance = AppPermissions._();

  Future<bool> requestVoicePermissions() async {
    const microphonePermission = Permission.microphone;

    if (await microphonePermission.isGranted) {
      return true;
    } else {
      final permissionStatus = await microphonePermission.request();

      if (permissionStatus.isGranted) {
        return true;
      } else {
        final shouldOpenSettings =
            await _shouldOpenSettings([microphonePermission]);

        if (shouldOpenSettings) {
          await _openAppSettings();
        }
        return false;
      }
    }
  }

  Future<bool> requestVideoPermissions() async {
    const microphonePermission = Permission.microphone;
    const cameraPermission = Permission.camera;

    if (await microphonePermission.isGranted &&
        await cameraPermission.isGranted) {
      return true;
    } else {
      final microphonePermissionStatus = await microphonePermission.request();
      final cameraPermissionStatus = await cameraPermission.request();

      if (microphonePermissionStatus.isGranted &&
          cameraPermissionStatus.isGranted) {
        return true;
      } else {
        final shouldOpenSettings =
            await _shouldOpenSettings([microphonePermission, cameraPermission]);

        if (shouldOpenSettings) {
          await _openAppSettings();
        }
        return false;
      }
    }
  }

  Future<bool> requestCameraPermission() async {
    const cameraPermission = Permission.camera;

    if (await cameraPermission.isGranted) {
      return true;
    } else {
      final permissionStatus = await cameraPermission.request();

      if (permissionStatus.isGranted) {
        return true;
      } else {
        final shouldOpenSettings =
            await _shouldOpenSettings([cameraPermission]);

        if (shouldOpenSettings) {
          await _openAppSettings();
        }
        return false;
      }
    }
  }

  Future<bool> requestMediaLibraryPermission() async {
    late final Permission mediaPermission;

    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if ((androidInfo.version.sdkInt) <= 32) {
        mediaPermission = Permission.storage;
      } else {
        mediaPermission = Permission.photos;
      }
    } else {
      mediaPermission = Permission.photos;
    }

    if (await mediaPermission.isGranted) {
      return true;
    } else {
      final permissionStatus = await mediaPermission.request();

      if (permissionStatus.isGranted) {
        return true;
      } else {
        final shouldOpenSettings = await _shouldOpenSettings([mediaPermission]);

        if (shouldOpenSettings) {
          await _openAppSettings();
        }
        return false;
      }
    }
  }

  Future<bool> requestCalendarPermission() async {
    const calendarPermission = Permission.calendarWriteOnly;

    if (await calendarPermission.isGranted) {
      return true;
    } else {
      final permissionStatus = await calendarPermission.request();

      if (permissionStatus.isGranted) {
        return true;
      } else {
        final shouldOpenSettings =
        await _shouldOpenSettings([calendarPermission]);

        if (shouldOpenSettings) {
          await _openAppSettings();
        }
        return false;
      }
    }
  }

  Future<bool> _shouldOpenSettings(List<Permission> permissions) async {
    for (final permission in permissions) {
      final isRestrictedOrPermanentlyDenied = await permission.isDenied ||
          await permission.isPermanentlyDenied ||
          await permission.isRestricted ||
          await permission.isLimited;

      if (isRestrictedOrPermanentlyDenied) {
        return true;
      }
    }
    return false;
  }

  Future<void> _openAppSettings() async {
    try {
      await openAppSettings();
    } on PlatformException catch (e) {
      debugPrint("Error opening app settings: $e");
    }
  }

}
