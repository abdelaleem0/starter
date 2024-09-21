
import 'package:starter/common/utils/common.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FcmTokenUseCase {

  Future<String> execute() async {
    try {
        final token = await FirebaseMessaging.instance.getToken();
        logDebug("FCM Token: $token}");
        return token ?? "";
    } catch(e) {
      logDebug(e);
      throw RetrieveFcmTokenFailureException();
    }
  }
}

class RetrieveFcmTokenFailureException implements Exception {}
