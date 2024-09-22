import 'package:get_it/get_it.dart';
import 'package:starter/app/authentication/di/authentication_injector.dart';
import 'package:starter/common/di/common_injector.dart';
import 'package:starter/common/utils/media_utils/src/injector/media_utils_injector.dart';
import 'package:starter/di/data_injector.dart';
import 'localizations_container.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.registerSingleton(LocalizationsContainer());

  injector.pushNewScope();
  await registerAppDependencies();
}

//TODO:use this func with AuthLogout func to resetScope.
Future<void> resetScopeDependencies() async {
  await injector.resetScope();
  await registerAppDependencies();
}

Future<void> registerAppDependencies() async {
  DataDi.initialize();
  CommonDi.initialize();
  AuthenticationDi.initialize();
  MediaUtilsDi.initialize();
}
