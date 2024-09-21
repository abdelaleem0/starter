import 'dart:async';

import 'package:starter/app/authentication/domain/models/otp_verification/resond_otp/resend_verification_otp_input.dart';
import 'package:starter/app/authentication/ui/email_verification/otp_verification_cubit.dart';
import 'package:starter/app/authentication/utils/localization/authentication_localizer.dart';
import 'package:starter/common/ui/custom_widgets/app_buttons/app_buttons.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';

const int _countTimerSeconds = 90;

class VerificationCodeTimer extends StatefulWidget {
  final ResendOtpInput resendOtpInput;

  const VerificationCodeTimer({
    super.key,
    required this.resendOtpInput,
  });

  @override
  State<VerificationCodeTimer> createState() =>
      _PhoneVerificationResendViewState();
}

class _PhoneVerificationResendViewState extends State<VerificationCodeTimer> {
  Timer? _timer;
  int timeRemainingInSeconds = _countTimerSeconds;
  static const tickDurationInSeconds = 1;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    _timer?.cancel();
    setState(() {
      timeRemainingInSeconds = _countTimerSeconds;
    });
    _timer =
        Timer.periodic(const Duration(seconds: tickDurationInSeconds), (timer) {
      setState(() {
        timeRemainingInSeconds =
            _countTimerSeconds - (timer.tick * tickDurationInSeconds);
        if (hasEnded()) {
          timer.cancel();
        }
      });
    });
  }

  bool hasEnded() {
    if (_countTimerSeconds > 600) {
      _timer?.cancel();
      return false;
    }
    return timeRemainingInSeconds <= 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          width: 2,
        ),
        _buildTimerButton(),
        const SizedBox(height: PaddingDimensions.normal),
        // if(hasEnded())...[
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text(AuthenticationLocalizer.resendCodeHint , style: TextStyles.regular(
        //         fontSize: Dimensions.normal,
        //         color: AppColors.neutral_900,
        //       )),
        //       SizedBox(width: PaddingDimensions.normal),
        //       GestureDetector(
        //         onTap: hasEnded() ? onResendSMSPressed : null,
        //         child: Text(
        //           AuthenticationLocalizer.resend,
        //           style: TextStyles.mediumUnderlined(
        //             fontSize: Dimensions.normal,
        //             color: AppColors.neutral_600,
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ],

      ],
    );
  }

  Widget _buildTimerButton() {
    if (_countTimerSeconds > 600) {
      return  AppButton.primaryButton(
          horizontalPadding: PaddingDimensions.x4Large,
          isShadow: false,
          isBold: false,
          fontSize: Dimensions.xxLarge,
          title: AuthenticationLocalizer.otpError,
          onPressed:  (){
          },
          isExpanded: true,
          textColor: AppColors.neutral_0,
          iconSize: 16,
          backgroundColor: Colors.transparent);
    } else {
      return  AppButton.primaryButton(
          key: const ValueKey(1),
          borderColor:hasEnded() ? AppColors.primaryColorsSolid4Default :AppColors.defaultGray,
          horizontalPadding: PaddingDimensions.x4Large,
          isShadow: false,
          isBold: false,
          fontSize: Dimensions.xxLarge,
          title: hasEnded()
              ? AuthenticationLocalizer.resend
              : AuthenticationLocalizer.resend + prettyRemainingTime(),
          textStyle: TextStyles.medium(
            color: hasEnded()
                ? AppColors.primaryColorsSolid4Default
                : AppColors.neutralColors5,
            fontSize: Dimensions.xxLarge,
          ),
          onPressed: hasEnded() ? onResendSMSPressed : (){

          },
          isExpanded: true,
          textColor: AppColors.defaultGray,
          iconSize: 16,
          backgroundColor: Colors.transparent);
    }
  }

  String prettyRemainingTime() {
    if (_countTimerSeconds > 600) {
      return "00";
    }
    int sec = timeRemainingInSeconds % 60;
    int min = (timeRemainingInSeconds / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute:$second";
  }

  void onResendSMSPressed() {
    OtpVerificationCubit.of(context).resendOtp(widget.resendOtpInput);
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
