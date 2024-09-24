import 'package:starter/common/utils/extensions/string.dart';

class Constants {
  static const packageName = "com.Starter";
  static const isProductionInDebug = false;
  static const isProduction = true  ? true : isProductionInDebug;

  static const String endpoint = isProduction
      ? 'isProduction'
      : 'staging';

  static const String subscriptionLink = isProduction
      ? 'isProduction'
      : 'staging';

  static const String baseUrl = isProduction
      ? 'isProduction'
      : 'staging';
  static String concatWithBaseUrl(String? url){
    if(url == null) return "";

    if(url.isNetwork){
      return url;
    }

    return baseUrl + url;
  }
}

