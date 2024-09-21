
import 'dart:async';

import 'package:starter/common/utils/common.dart';
import 'package:ntp/ntp.dart';

class RealTimeTimer {
  DateTime? _currentTime;
  Timer? timer;

  Future<bool> init() async {
    try {
      _currentTime = await NTP.now(timeout: const Duration(minutes: 1));
      if (timer != null) {
        timer?.cancel();
        timer = null;
      }
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _currentTime = _currentTime!.add(const Duration(seconds: 1));
      });

      return true;
    } catch (e) {
      logDebug("Time Error: $e");
    }

    return false;
  }

  DateTime getCurrentDateTime() {
    if (_currentTime == null) {
      init();
      return DateTime.now();
    }
    return _currentTime!;
  }
}
