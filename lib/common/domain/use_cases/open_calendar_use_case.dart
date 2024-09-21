import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class OpenCalendarUseCase {
  OpenCalendarUseCase();
  Future<void> call() async {
    String url = Platform.isAndroid
        ? 'content://com.android.calendar/time/'
        : 'calshow://';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
