import 'package:starter/app/authentication/domain/models/otp_verification/otp_verification/otp_verification_input.dart';
import 'package:starter/app/authentication/domain/models/otp_verification/otp_verification_type.dart';
import 'package:starter/app/authentication/domain/models/otp_verification/resond_otp/resend_verification_otp_input.dart';
import 'package:starter/app/authentication/domain/models/social/social_provider_type.dart';
import 'package:starter/app/authentication/ui/complete_register/first_name/first_name_page.dart';
import 'package:starter/app/authentication/ui/email_verification/otp_verification_cubit.dart';
import 'package:starter/app/authentication/ui/email_verification/otp_verification_state.dart';
import 'package:starter/app/authentication/ui/forget_password/reset_password/reset_password_page.dart';
import 'package:starter/app/authentication/ui/social/auth_package_singlton/auth_package_singlton.dart';
import 'package:starter/app/authentication/ui/social/merge/social_merge_bottom_sheet.dart';
import 'package:starter/app/authentication/utils/localization/authentication_localizer.dart';
import 'package:starter/common/blocs/authentication/authentication_bloc.dart';
import 'package:starter/common/blocs/authentication/events.dart';
import 'package:starter/common/blocs/authentication/states.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import 'package:starter/common/ui/custom_widgets/app_buttons/app_buttons.dart';
import 'package:starter/common/ui/custom_widgets/pin_code_widget.dart';
import 'package:starter/common/utils/app_routes/router_functions.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/assets_paths/svg_paths.dart';
import 'package:starter/common/utils/common.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class EmailVerificationForm extends StatefulWidget {
  final ResendOtpInput resendOtpInput;

  const EmailVerificationForm({
    super.key,
    required this.resendOtpInput,
  });

  @override
  State<EmailVerificationForm> createState() => _EmailVerificationFormState();
}

class _EmailVerificationFormState extends State<EmailVerificationForm> {
  var _code = '';
  final formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final provider =
      SocialAuthPackagesResultSingleton.instance?.packageData?.provider;

  void _onSubmitPressed() {
    final input = OtpVerificationInput(
        otpVerificationType: widget.resendOtpInput.otpVerificationType,
        verificationCode: _codeController.text,
        email: widget.resendOtpInput.email);
    OtpVerificationCubit.of(context).verifyOtp(input);
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void onCodeChanged(String value) {
    OtpVerificationCubit.of(context).restOtp();
    _code = _codeController.text;
    if (_code.length == 4) {
      FocusScope.of(context).unfocus();
    }
  }

  void _handleVerifyOtpIsSuccess(
      BuildContext context, OtpVerificationState state) {
    if (state.verifyOtp.data != null) {
      BlocProvider.of<UserCubit>(context).setAppUserModel(
        state.verifyOtp.data?.appUserModel ?? const AppUserModel.initial(),
      );
      switch (widget.resendOtpInput.otpVerificationType) {
        case OtpVerificationType.passwordReset:
          final input = OtpVerificationInput(
              otpVerificationType: widget.resendOtpInput.otpVerificationType,
              verificationCode: _codeController.text,
              email: widget.resendOtpInput.email);
          AppRouteNavigator.push(
            context,
            ResetPasswordPage.routeName,
            ResetPasswordPage(
              input: input,
            ),
          );

          break;
        case OtpVerificationType.formRegister:
          AppRouteNavigator.push(
            context,
            FirstNamePage.routeName,
            const FirstNamePage(),
          );
          break;
        case OtpVerificationType.socialRegister:
          AppRouteNavigator.popUntil(context, removeUntil: "/");
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AppEnableBiometricEvent());
          break;
        case OtpVerificationType.socialMerge:
          //todo:localization
          SocialMergeBottomSheet.openBottomSheet(
            context: context,
            title: "Looks like you already have an Ajmal account!",
            socialIcon: provider == SocialProviderTypeEnum.apple
                ? SvgPaths.apple
                : null,
            description: provider == SocialProviderTypeEnum.apple
                ? "An account with this Email address already exists and connected to Apple, Would you like to link it with this Apple account?"
                : "An account with this Email address already exists and connected to Google, Would you like to link it with this Google account?",
            confirmButtonText: "Link accounts",
          );
          break;
        case OtpVerificationType.changeEmail:
        //Todo this for settings
        // if(NestedNavObserver.instance.isBeforeMainHostPage()){
        //   AppRouteNavigator.pop(context);
        // }else{
        //   AppRouteNavigator.popNested(context,data: CommonLocalizer.emailIsUpdatedSuccessfully);
        //   AppRouteNavigator.popNested(context,data:  CommonLocalizer.emailIsUpdatedSuccessfully);
        // }

        // BlocProvider.of<UserCubit>(context)
        //     .updateEmail(widget.resendOtpInput.email);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthState>(
      listenWhen: (previous, current) => current is AuthAuthenticated,
      listener: (context, state) {
        AppRouteNavigator.popUntil(context);
      },
      child: BlocListener<OtpVerificationCubit, OtpVerificationState>(
        listenWhen: (previous, current) =>
            previous.resendOtp != current.resendOtp,
        listener: (context, state) {
          if (state.resendOtp.isFailure) {
            showTopSnackError(
                text: "${state.resendOtp.errorMessage}", context: context);
          }
        },
        child: BlocConsumer<OtpVerificationCubit, OtpVerificationState>(
          listener: (context, state) {
            if (state.verifyOtp.isSuccess) {
              _handleVerifyOtpIsSuccess(context, state);
            }
            if (state.errorMessage?.isNotEmpty ?? false) {
              showTopSnackError(
                  text: state.errorMessage ?? '', context: context);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: PinCodeWidget(
                    codeController: _codeController,
                    hasError: state.verifyOtp.isFailure,
                    onChange: onCodeChanged,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: state.verifyOtp.isFailure
                      ? Row(
                          children: [
                            const Icon(
                              Iconsax.info_circle5,
                              color: AppColors.semanticColorsError4Default,
                            ),
                            const SizedBox(
                              width: PaddingDimensions.medium,
                            ),
                            Text(
                              state.verifyOtp.errorMessage ?? "",
                              style: TextStyles.regular(
                                fontSize: Dimensions.xLarge,
                                color: AppColors.semanticColorsError4Default,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(
                  height: PaddingDimensions.xxLarge,
                ),
                AppButton.primaryButton(
                    horizontalPadding: PaddingDimensions.x4Large,
                    isBold: false,
                    fontSize: Dimensions.xxLarge,
                    title: AuthenticationLocalizer.verify,
                    onPressed: _code.isEmpty ? null : _onSubmitPressed,
                    isExpanded: true,
                    textColor: AppColors.neutral_0,
                    iconSize: 16,
                    isLoading: state.verifyOtp.isLoading,
                    backgroundColor: AppColors.primaryColorsSolid4Default),
                const SizedBox(
                  height: PaddingDimensions.large,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
