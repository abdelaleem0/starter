import 'package:starter/app/authentication/domain/models/inputs/forgot_password_input.dart';
import 'package:starter/app/authentication/domain/models/otp_verification/otp_verification_type.dart';
import 'package:starter/app/authentication/ui/email_verification/otp_verification_page.dart';
import 'package:starter/app/authentication/ui/forget_password/forget_password/manager/forget_password_cubit.dart';
import 'package:starter/app/authentication/ui/forget_password/forget_password/manager/forget_password_state.dart';
import 'package:starter/app/authentication/ui/register/sign_up_page.dart';
import 'package:starter/app/authentication/ui/widgets/already_have_account_widget.dart';
import 'package:starter/app/authentication/ui/widgets/email_widget.dart';
import 'package:starter/app/authentication/utils/localization/authentication_localizer.dart';
import 'package:starter/common/ui/custom_widgets/app_buttons/app_buttons.dart';
import 'package:starter/common/utils/app_routes/router_functions.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/common.dart';
import 'package:starter/common/utils/complete_checker_notifier.dart';
import 'package:starter/common/utils/custom_widgets/application_app_bars.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/ui/header_widget.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  static String routeName = "ForgetPasswordPage";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.neutral_0,
        appBar: ApplicationAppBars.defaultAppBar(
          context: context,
          useCloseButton: true,
        ),
        body: const _ForgetPasswordBody(),
      ),
    );
  }
}

class _ForgetPasswordBody extends StatefulWidget {
  const _ForgetPasswordBody();

  @override
  State<_ForgetPasswordBody> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<_ForgetPasswordBody> {
  final _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late CompleteCheckerNotifier _dataCompletedNotifier;

  bool isCompleteDataFilled() {
    return (_emailController.text.isNotEmpty);
  }

  @override
  void initState() {
    _dataCompletedNotifier = CompleteCheckerNotifier(
      () => isCompleteDataFilled(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _dataCompletedNotifier.dispose();
    super.dispose();
  }

  void _navigateToSignUpPage() {
    FocusNode().requestFocus();
    AppRouteNavigator.pushAndRemoveUntil(
      context,
      SignUpPage.routeName,
      const SignUpPage(),
      removeUntil: "/"
    );
  }

  void _onForgetPasswordIsSuccess() {
    AppRouteNavigator.push(
      context,
      OtpVerificationPage.routeName,
      OtpVerificationPage(
        otpVerificationType: OtpVerificationType.passwordReset,
        email: _emailController.text,
      ),
    );
  }

  Future<void> _verifyEmail() async {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).requestFocus(FocusNode());

      final verificationEmailCubit =
          BlocProvider.of<ForgetPasswordCubit>(context);

      final forgotPasswordInput = ForgotPasswordInput(
        email: _emailController.text,
      );

      verificationEmailCubit.verifyEmail(forgotPasswordInput);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state.verifyEmailState.isSuccess) {
          _onForgetPasswordIsSuccess();
        } else if (state.verifyEmailState.isFailure) {
          showTopSnackError(
              context: context,
              text: state.verifyEmailState.errorMessage ?? "");
        }
      },
      buildWhen: (previous, current) =>
          previous.verifyEmailState != current.verifyEmailState,
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: Dimensions.pageSmallMargins,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: PaddingDimensions.xxLarge,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: PaddingDimensions.x4Large),
                        child: HeaderWidget(
                          title: AuthenticationLocalizer.resetPassword,
                          description:
                              AuthenticationLocalizer.resetPasswordDescription,
                        ),
                      ),
                      const SizedBox(height: PaddingDimensions.x4Large),
                      EmailWidget(
                        controller: _emailController,
                        onChange: (text) {
                          return _dataCompletedNotifier.checkIsDataCompleted();
                        },
                      ),
                      const SizedBox(
                        height: PaddingDimensions.xxxLarge,
                      ),
                      ValueListenableBuilder(
                        valueListenable: _dataCompletedNotifier,
                        builder: (context, value, child) {
                          return AppButton.primaryButton(
                            isLoading: state.verifyEmailState.isLoading,
                            horizontalPadding: PaddingDimensions.x4Large,
                            isShadow: false,
                            isBold: false,
                            isExpanded: true,
                            fontSize: Dimensions.xxLarge,
                            onPressed: value ? _verifyEmail : null,
                            title: AuthenticationLocalizer.next,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                AlreadyOrDontHaveAccount(
                  text: AuthenticationLocalizer.dontHaveAnAccount,
                  clickableText: AuthenticationLocalizer.signUp,
                  onTap: _navigateToSignUpPage,
                ),
                const SizedBox(
                  height: PaddingDimensions.x4Large,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
