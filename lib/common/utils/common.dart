import 'dart:async';
import 'dart:io';
import 'dart:math';
// import 'package:starter/app/remote_config/firebase_remote_config_keys.dart';
// import 'package:starter/app/remote_config/manager/firebase_remote_config_manager.dart';
import 'package:starter/common/ui/custom_widgets/app_alert/app_alerts.dart';
import 'package:starter/common/ui/custom_widgets/app_toast/toast.dart';
import 'package:starter/common/utils/constants.dart';
import 'package:starter/common/utils/extensions/extensions.dart';
import 'package:starter/common/utils/extensions/string.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/localization/common_localizer.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app_style/app_colors.dart';
import 'dart:core';
import 'package:intl/intl.dart' as intl;

//TODO: Arabic Utils, ex: support two items and plurals + numbers format

bool isLocaleArabic(BuildContext context) {
  return Localizations.localeOf(context).languageCode.contains('ar');
}

void logDebug(Object? object) {
  if (kDebugMode) {
    print(object);
  }
}

Size getWindowSize(BuildContext context) => MediaQuery.of(context).size;

bool isRTL(String text) {
  return intl.Bidi.detectRtlDirectionality(text);
}

const shortDurationInSec = 3;
const longDurationInSec = 6;
const String successIcon = "images/common/successIcon.png";
const String errorIcon = "images/common/errorIcon.png";


String getTodayWeekDay(String lang) {
  final current = DateTime.now();
  return DateFormat.EEEE(lang).format(current);
}

String getCurrentYear(String lang) {
  return DateFormat.y(lang).format(DateTime.now());
}


T? listGetOrNull<T>(int index, List<T> list) {
  if (index >= list.length || index < 0) {
    return null;
  }
  return list[index];
}

List<T> listTakeFirst<T>(int n, List<T> list) {
  if (list.length > n) {
    return list.take(n).toList();
  }
  return list;
}

void forEachIndexed<T>(
    List<T> list, void Function(int index, T element) block) {
  for (int i = 0; i < list.length; i++) {
    block(i, list[i]);
  }
}

String convertArabicNumbersToEnglish(String str) {
  return str
      .replaceAll("٠", "0")
      .replaceAll("١", "1")
      .replaceAll("٢", "2")
      .replaceAll("٣", "3")
      .replaceAll("٤", "4")
      .replaceAll("٥", "5")
      .replaceAll("٦", "6")
      .replaceAll("٧", "7")
      .replaceAll("٨", "8")
      .replaceAll("٩", "9");
}

String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
}

Future<double> getFileSizeInMb(String filePath) async {
  final bytes = await File.fromUri(Uri.parse(filePath)).length();
  final kb = bytes / 1024;
  return (kb / 1024); // in mb
}

double roundDoubleNumbers(double value, int places){
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

Future<dynamic> waitFor(Duration duration) {
  final completer = Completer();
  Timer(duration, () {
    completer.complete();
  });
  return completer.future;
}

void canPopFunction(BuildContext context) {
  if (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
  } else {
    Navigator.of(context, rootNavigator: true).pop();
  }
}

shareText(String data) {
  Share.share(data);
}

shareLink(String link) {
  Share.share(link);
}

shareFile(File file) async {
  try {
    await Share.shareXFiles([XFile(file.path)]);
  } catch (exception) {
  }
}

shareImageLink(String identifier , String id) {
  Share.share("${Constants.baseUrl}$identifier$id");
}

sharePdfLink(String identifier , String id) {
  Share.share("${Constants.baseUrl}$identifier$id");
}

void showSuccessDownloadToast(BuildContext context, String messageSuccess) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(messageSuccess),
      //Todo(Add Localization)
      action: SnackBarAction(
          label: 'hide',
          onPressed: scaffold.hideCurrentSnackBar), //Todo(Add Localization)
    ),
  );
}

void showErrorBanner({required BuildContext context, required String text}) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.info(
      textAlign: TextAlign.center,
      backgroundColor: AppColors.neutral_0,
      icon: const Icon(
        Icons.error_outline,
        color: Colors.red,
      ),
      iconRotationAngle: 0,
      iconPositionLeft: 20,
      messagePadding:
          const EdgeInsets.symmetric(horizontal: PaddingDimensions.x6Large),
      message: text,
      textStyle: const TextStyle(color: AppColors.neutral_900),
    ),
    displayDuration: const Duration(milliseconds: 400),
    persistent: true,
    dismissType: DismissType.onTap,
    dismissDirection: [DismissDirection.endToStart],
  );
}

bool isSvgImage(String imagePath) {
  return imagePath.endsWith(".svg");
}

Future<void> showTopSnackError(
    {required String text,
    required BuildContext context,
    Duration? duration}) async {
  errorToast(context, message: text, duration: duration);
}

Future<void> showTopSnackSuccess(
    {required String text,
    required BuildContext context,
    Duration? duration,
    Color? backgroundColor}) async {
  successToast(context,
      message: text, duration: duration, backgroundColor: backgroundColor);
}

Future<void> showDefaultSnack(
    {required String text,
      required BuildContext context,
      Duration? duration,
      Color? backgroundColor}) async {
  defaultToast(context,
      message: text, duration: duration, backgroundColor: backgroundColor);
}
String concatWithBaseUrl(String image) {
  return Constants.baseUrl + image;
}



Future<void> copyTextToClipboard(String text) async {
  await Clipboard.setData(ClipboardData(text: text));
}

String checkerTimer(Locale locale, DateTime initialTime) {
  // DateTime initialTimeOfAnswer = DateTime(2023, 5, 28, 14, 40, 20, 00, 00);// this to test
  // DateTime now = RealTimeTimer.instance.getCurrentDateTime();
  DateTime now = DateTime.now();

  var differenceDuration = now.difference(initialTime);
  if (differenceDuration.inHours <= 0 &&
      differenceDuration.inDays <= 0 &&
      differenceDuration.inMinutes <= 0 &&
      differenceDuration.inSeconds <= 0) {
    return CommonLocalizer.justNow;
  } else if (differenceDuration.inHours == 0 &&
      differenceDuration.inDays == 0 &&
      differenceDuration.inMinutes == 0) {
    return '${differenceDuration.inSeconds} ${CommonLocalizer.second}';
  } else if (differenceDuration.inHours == 0 &&
      differenceDuration.inDays == 0) {
    return '${differenceDuration.inMinutes} ${CommonLocalizer.m}';
  } else if (differenceDuration.inHours != 0 &&
      differenceDuration.inDays == 0) {
    return '${differenceDuration.inHours} ${CommonLocalizer.h}';
  } else if (differenceDuration.inHours != 0 &&
      differenceDuration.inDays == 1) {
    return '${differenceDuration.inDays} ${CommonLocalizer.day}';
  } else if (differenceDuration.inHours != 0 &&
      differenceDuration.inDays != 0 &&
      differenceDuration.inDays < 7) {
    return '${differenceDuration.inDays} ${CommonLocalizer.days}';
  } else if (differenceDuration.inDays > 6 && differenceDuration.inDays < 365) {
    return '${convertDateToDayAndMonth(initialTime, locale)} ';
  } else if (differenceDuration.inDays > 365) {
    return '${convertDateToFullDate(initialTime)} ';
  } else {
    return '';
  }
}

String convertDateToFullDate(DateTime date) {
  final currentDateTime = (DateFormat(
    'y-MM-d',
  ).parse(DateFormat(
    'y-MM-d',
  ).format(date)));

  var result = DateFormat(
    'y-MM-d',
  ).format(currentDateTime);

  return result;
}

// 11 فبراير
String convertDateToDayAndMonth(DateTime date, Locale locale) {
  final currentDateTime =
  (DateFormat('d MMMM').parse(DateFormat('d MMMM').format(date)));

  var result =
  DateFormat('d MMMM', locale.toLanguageCountry()).format(currentDateTime);

  return result.convertArabicNumbersToEnglish();
}


// String getAppropriateDifference(DateTime dateTime) {
//   final duration = DateTime.now().difference(dateTime);
//   if (duration.inDays > 365) {
//     return "${(duration.inDays / 365).floor()} y";
//   } else if (duration.inDays < 365 && duration.inDays > 0) {
//     return "${(duration.inDays / 30).floor()} months";
//   } else if (duration.inHours > 0) {
//     return "${(duration.inHours)} h";
//   } else if (duration.inMinutes > 0) {
//     return "${(duration.inMinutes)} min";
//   } else if (duration.inSeconds > 0) {
//     return "${(duration.inSeconds)} s";
//   } else {
//     return "Just now";
//   }
// }

  String formatFromDateToDate({required DateTime startDate,required DateTime endDate}){
    DateFormat monthDayFormat = DateFormat("dd MMM");

    String formattedStartDate = monthDayFormat.format(startDate);
    String formattedEndDate = monthDayFormat.format(endDate);

    String fullDateRange = "$formattedStartDate - $formattedEndDate, ${endDate.year}";
    return fullDateRange;
  }

  ({String datePart,String timePart}) formatToReadableDateAndTime(
    DateTime startDate,
    DateTime endData,
  ) {

  String formattedDate = DateFormat('dd MMM, yyyy').format(startDate);
  String formattedStartTime = DateFormat('h:mm a').format(startDate);
  String formattedEndTime = DateFormat('h:mm a').format(endData);

  //take anyone start or end
  String offset = startDate.timeZoneOffset.toString().split('.').first;
  var hourOffset = offset.split(":").first;
  if(!hourOffset.contains("-")){
    hourOffset = "+$hourOffset";
  }

  return (
    datePart: formattedDate,
    timePart: '$formattedStartTime - $formattedEndTime - UTC $hourOffset'
  );
}

openSubscriptionStore(BuildContext context) async {
  if (Platform.isIOS) {
    showTopSnackSuccess(text: "No Subscriptions in IOS", context: context);
  } else {
    const String effectiveURL =
        "https://play.google.com/store/account/subscriptions?package=${Constants.packageName}";

    if (await canLaunchUrl(Uri.parse(effectiveURL))) {
      await launchUrl(Uri.parse(effectiveURL),
          mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Failed to launch url: $effectiveURL');
    }
  }


}
void showUpdateAlert(BuildContext context) {
  AppAlerts.successAlertDialog(
    context,
    title: "New update available ",
    subTitle:
    "A new version of the app is available! Update now to enjoy the latest features and improvements.",
    primaryButtonText: "Update now ",
    primaryButtonColor: AppColors.primary_400,
    showCloseButton: false,
    onPressSuccess: () async {
   await   openStore();
    },
  );
}

void showRequiredUpdateAlert(BuildContext context) {
  AppAlerts.successAlertDialog(
    context,
    title: "New update available ",
    subTitle:
    "A new version of the app is available! Update now to enjoy the latest features and improvements.",
    primaryButtonText: "Update now ",
    primaryButtonColor: AppColors.primary_400,
    showCloseButton: false,
    canPop: false,
    onPressSuccess: () async {
      await openStore();
    },
  );
}

openStore() async {
  final applicationLink = Platform.isAndroid
      ? 'https://play.google.com/store/apps/details?id=${Constants.packageName}'
      : 'https://apps.apple.com/app/6633426653';
  if (await canLaunchUrl(Uri.parse(applicationLink))) {
    await launchUrl(Uri.parse(applicationLink),
        mode: LaunchMode.externalApplication);
  }
}

// void checkForAppUpdate(BuildContext context) async {
//   final SharedPreferencesHelperImp prefs = SharedPreferencesHelperImp();
//   String appStoreVersion = await FirebaseRemoteConfigManager.instance
//           .getString(FirebaseRemoteConfigKeys.appStoreVersion) ??
//       '_';
//   bool isUpdateRequired = await FirebaseRemoteConfigManager.instance
//           .getBool(FirebaseRemoteConfigKeys.updateRequired) ??
//       false;
//   String appVersion = await getVersionInfo();
//   String prefsVersion = await prefs.getVersion() ?? '';
//   if (appStoreVersion != appVersion) {
//     if (isUpdateRequired) {
//       showRequiredUpdateAlert(context);
//       prefs.setVersion(appStoreVersion);
//     } else {
//       if (prefsVersion.isEmpty) {
//         showUpdateAlert(context);
//         prefs.setVersion(appStoreVersion);
//       } else {
//         int intAppStoreVersion = int.parse(appStoreVersion.replaceAll(".", ''));
//         int intPrefsVersion = int.parse(prefsVersion.replaceAll(".", ''));
//         if (intAppStoreVersion - 1 >= intPrefsVersion) {
//           showUpdateAlert(context);
//           prefs.setVersion(appStoreVersion);
//         }
//       }
//     }
//   }
// }

Future<String> getVersionInfo() async{
  String version = '';
  await PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
    version = packageInfo.version;
  });
  return version;

}