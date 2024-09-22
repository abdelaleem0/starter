import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starter/di/app_injector.dart';
import 'package:starter/di/app_starter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ///ToDo: this to Show StatusBar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);
  ///ToDo: this to hide StatusBar
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  // await _setCertificatesForOldDevices();

  await initializeDependencies();
  // await PreferencesHelperImp(injector()).deleteToken();
  // FlutterNativeSplash.remove();
  // injector<PreferencesHelper>().deleteToken();
  // await Future.delayed(const Duration(seconds: 1));  // for splash screen Todo(maybe need to delete this delay) in android 13 it appears and remove immediately.
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
    // name: "Ajmal"
  // );




  runApp(const TheAppUser());
}