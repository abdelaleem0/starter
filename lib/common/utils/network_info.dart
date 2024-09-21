import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get hasConnection;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker internetConnectionChecker;

  NetworkInfoImpl(this.internetConnectionChecker);

  @override
  Future<bool> get hasConnection async =>
      await internetConnectionChecker.hasConnection;
}

class CheckInternetConnectionUseCase {
  final NetworkInfo networkInfo;

  CheckInternetConnectionUseCase(this.networkInfo);

  Future<bool> execute() async => await networkInfo.hasConnection;
}
