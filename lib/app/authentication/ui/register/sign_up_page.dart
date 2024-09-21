import 'package:starter/app/authentication/domain/models/inputs/register_input.dart';
import 'package:starter/app/authentication/domain/models/otp_verification/otp_verification_type.dart';
import 'package:starter/app/authentication/ui/email_verification/otp_verification_page.dart';
import 'package:starter/app/authentication/ui/login/login_page.dart';
import 'package:starter/app/authentication/ui/register/manager/sign_up_cubit.dart';
import 'package:starter/app/authentication/ui/register/manager/sign_up_state.dart';
import 'package:starter/app/authentication/ui/widgets/alert_dialog_otp_error.dart';
import 'package:starter/app/authentication/ui/widgets/already_have_account_widget.dart';
import 'package:starter/app/authentication/ui/widgets/email_widget.dart';
import 'package:starter/app/authentication/ui/widgets/password_widget.dart';
import '../../../../../common/ui/header_widget.dart';
import 'package:starter/app/authentication/utils/localization/authentication_localizer.dart';
import 'package:starter/common/domain/models/otp.dart';
import 'package:starter/common/ui/custom_widgets/app_buttons/app_buttons.dart';
import 'package:starter/common/utils/app_routes/router_functions.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/common.dart';
import 'package:starter/common/utils/complete_checker_notifier.dart';
import 'package:starter/common/utils/custom_widgets/application_app_bars.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/localization/common_localizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({
    super.key,
  });

  static const String routeName = "UserRegisterPage";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: Scaffold(
        appBar: ApplicationAppBars.defaultAppBar(
          context: context,
          useCloseButton: true,
        ),
        backgroundColor: AppColors.neutral_0,
        extendBodyBehindAppBar: false,
        resizeToAvoidBottomInset: false,
        body: const _UserRegisterBody(),
      ),
    );
  }
}

class _UserRegisterBody extends StatefulWidget {
  const _UserRegisterBody();

  @override
  State<_UserRegisterBody> createState() => _UserRegisterBodyState();
}

class _UserRegisterBodyState extends State<_UserRegisterBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  late CompleteCheckerNotifier _dataCompletedNotifier;

  void _navigateToLoginPage(context) {
    AppRouteNavigator.pushReplacement(
      context,
      LoginPage.routeName,
      const LoginPage(),
    );
  }

  bool isSnakeBarShow = false;

  bool isCompleteDataFilled() {
    return (_emailTextController.text.isNotEmpty) &&
        (_passwordTextController.text.isNotEmpty);
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
    _emailTextController.dispose();
    _dataCompletedNotifier.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  void _onNextSignUpPress() {
    if (_formKey.currentState?.validate() == true) {
      FocusScope.of(context).unfocus();
      final input = RegisterInput(
        email: _emailTextController.text.trim(),
        password: _passwordTextController.text.trim(),
      );
      SignUpCubit.get(context).userRegisterFuc(input: input);
    }
  }

  void _onRegisterStateIsSuccess(context) {
    AppRouteNavigator.push(
        context,
        OtpVerificationPage.routeName,
        OtpVerificationPage(
            email: _emailTextController.text,
            otpVerificationType: OtpVerificationType.formRegister));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.userRegisterState.isSuccess) {
          _onRegisterStateIsSuccess(context);
        }
        if (state.errorMessage != null) {
          showTopSnackError(
              context: context, text: state.errorMessage.toString());
        }
        if (state.isBlocked.isSuccess) {
          AlertDialogOTPError.showAlertDialogOTPError(
              context, state.isBlocked.data ?? OTP(0, DateTime.now(), false));
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: PaddingDimensions.large),
          child: Column(
            children: [
              const SizedBox(
                height: PaddingDimensions.xxLarge,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: PaddingDimensions.x4Large),
                child: HeaderWidget(
                  title: AuthenticationLocalizer.signUp,
                  description: AuthenticationLocalizer.signUpDescription,
                ),
              ),
              const SizedBox(height: PaddingDimensions.x4Large),
              EmailWidget(
                controller: _emailTextController,
                onChange: (text) {
                  if (text.isEmpty) {
                    FocusScope.of(context).unfocus();
                    setState(() {});
                  }
                  return _dataCompletedNotifier.checkIsDataCompleted();
                },
              ),
              const SizedBox(
                height: PaddingDimensions.large,
              ),
              PasswordWidget(
                // showPasswordValidator: true,
                controller: _passwordTextController,
                onChange: (text) {
                  return _dataCompletedNotifier.checkIsDataCompleted();
                },
              ),
              const SizedBox(
                height: PaddingDimensions.x4Large,
              ),
              BlocBuilder<SignUpCubit, SignUpState>(
                builder: (context, state) {
                  return ValueListenableBuilder(
                    valueListenable: _dataCompletedNotifier,
                    builder: (context, value, child) {
                      return AppButton.primaryButton(
                        horizontalPadding: PaddingDimensions.x4Large,
                        isShadow: false,
                        isBold: false,
                        title: CommonLocalizer.next,
                        onPressed: value ? _onNextSignUpPress : null,
                        isExpanded: true,
                        textColor: AppColors.neutral_0,
                        isLoading: state.userRegisterState.isLoading,
                      );
                    },
                  );
                },
              ),
              const Spacer(),
              AlreadyOrDontHaveAccount(
                text: AuthenticationLocalizer.alreadyHaveAnAccount,
                clickableText: AuthenticationLocalizer.logIn,
                onTap: () {
                  FocusNode().requestFocus();
                  _navigateToLoginPage(context);
                },
              ),
              const SizedBox(
                height: PaddingDimensions.x6Large,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
