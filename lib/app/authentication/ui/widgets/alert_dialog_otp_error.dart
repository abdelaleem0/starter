import 'dart:async';

import 'package:starter/app/authentication/utils/localization/authentication_localizer.dart';
import 'package:starter/common/domain/models/otp.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';


class AlertDialogOTPError extends StatefulWidget {
  final OTP otp;

  const AlertDialogOTPError({super.key , required this.otp});

  static void showAlertDialogOTPError(context, OTP otp) {
    showDialog(
      context: context,
      builder: (context) {
        return  AlertDialog(
          content: AlertDialogOTPError(otp:otp),
        );
      },
    );
  }

  @override
  State<AlertDialogOTPError> createState() => _AlertDialogOTPErrorState();
}

class _AlertDialogOTPErrorState extends State<AlertDialogOTPError> {
  Timer? timer;
  int timeRemainingInSeconds=0;
  int blockTime=0;
  final dateNow=DateTime.now();
  Duration? duration;

  @override
  void initState() {
    duration=widget.otp.firstOTPTime.add(const Duration(minutes: 1)).difference(dateNow);
    blockTime=(duration?.inSeconds??0);
    timeRemainingInSeconds=blockTime;
    startTimer();
    super.initState();
  }
  void startTimer() {
    timer=Timer.periodic(const Duration(seconds: 1), (timer) {
      blockTime--;
      timeRemainingInSeconds=blockTime;
      if(timeRemainingInSeconds>=0){
        setState(() {
          timeRemainingInSeconds;
        });
      }else{
        timer.cancel();
        Navigator.pop(context);
      }
    });
  }

  String prettyRemainingTime() {
    int sec = timeRemainingInSeconds % 60;
    int min = (timeRemainingInSeconds / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min":"$min";
    String second = sec.toString().length <= 1 ? "0$sec":"$sec";
    return "$minute:$second";
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Text(
      "${AuthenticationLocalizer.otpError} ${prettyRemainingTime()}" ,
      style: TextStyles.regular(fontSize: Dimensions.large),
    );
  }


}
