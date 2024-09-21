import 'package:starter/app/authentication/domain/models/otp_verification/otp_verification_type.dart';
import 'package:starter/app/authentication/domain/models/otp_verification/resond_otp/resend_verification_otp_input.dart';
import 'package:starter/app/authentication/ui/email_verification/otp_verification_state.dart';
import 'package:starter/app/authentication/ui/email_verification/otp_verification_cubit.dart';
import 'package:starter/app/authentication/ui/email_verification/widgets/verification_code_timer.dart';
import 'package:starter/app/authentication/ui/email_verification/widgets/verification_form.dart';
import 'package:starter/app/authentication/ui/widgets/alert_dialog_otp_error.dart';
import 'package:starter/app/authentication/utils/localization/authentication_localizer.dart';
import 'package:starter/common/domain/models/otp.dart';
import 'package:starter/common/utils/app_routes/router_functions.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/custom_widgets/application_app_bars.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpVerificationPage extends StatelessWidget {
  static String routeName = "OtpVerificationPage";
  final String email;
  final OtpVerificationType otpVerificationType;

  const OtpVerificationPage({
    super.key,
    required this.email,
    required this.otpVerificationType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpVerificationCubit(),
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: AppColors.neutral_0,
          extendBody: true,
          appBar: ApplicationAppBars.defaultAppBar(
            context: context,
            useCloseButton: true,
          ),
          body: OtpVerificationBody(
              email: email, otpVerificationType: otpVerificationType),
        ),
      ),
    );
  }
}

class OtpVerificationBody extends StatefulWidget {
  final String email;
  final OtpVerificationType otpVerificationType;

  const OtpVerificationBody({
    super.key,
    required this.otpVerificationType,
    required this.email,
  });

  @override
  State<OtpVerificationBody> createState() => _OtpVerificationBodyState();
}

class _OtpVerificationBodyState extends State<OtpVerificationBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PaddingDimensions.large),
      child: BlocListener<OtpVerificationCubit, OtpVerificationState>(
        listener: (context, state) {
          if (state.otp.data?.isBlocked ?? false) {
            Navigator.of(context).pop(true);
            AlertDialogOTPError.showAlertDialogOTPError(
                context, state.otp.data ?? OTP(0, DateTime.now(), false));
          }
        },
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: PaddingDimensions.large,
              ),
              const SizedBox(height: PaddingDimensions.xxLarge),
              EmailVerificationForm(
                resendOtpInput: ResendOtpInput(
                    email: widget.email,
                    otpVerificationType: widget.otpVerificationType),
              ),
              VerificationCodeTimer(
                resendOtpInput: ResendOtpInput(
                    email: widget.email,
                    otpVerificationType: widget.otpVerificationType),
              ),
              const SizedBox(
                height: PaddingDimensions.x4Large,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AuthenticationLocalizer.notYou,
                      style: TextStyles.regular(
                          color: AppColors.defaultGray,
                          fontSize: Dimensions.xxLarge)),
                  const SizedBox(
                    width: PaddingDimensions.small,
                  ),
                  InkWell(
                      onTap: () {
                        FocusNode().requestFocus();
                        AppRouteNavigator.pop(context);
                      },
                      child: Text(
                        AuthenticationLocalizer.changeEmail,
                        style: TextStyles.medium(
                            color: AppColors.primaryColorsSolid4Default,
                            fontSize: Dimensions.xxLarge),
                      )),
                ],
              ),
              const SizedBox(
                height: PaddingDimensions.xLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
