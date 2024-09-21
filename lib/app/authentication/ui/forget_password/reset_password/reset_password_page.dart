import 'package:starter/app/authentication/domain/models/inputs/update_password_input.dart';
import 'package:starter/app/authentication/domain/models/otp_verification/otp_verification/otp_verification_input.dart';
import 'package:starter/app/authentication/ui/forget_password/reset_password/reset_password_cubit.dart';
import 'package:starter/app/authentication/ui/login/login_page.dart';
import 'package:starter/app/authentication/ui/widgets/password_widget.dart';
import '../../../../../common/ui/header_widget.dart';
import 'package:starter/app/authentication/utils/localization/authentication_localizer.dart';
import 'package:starter/common/base/async.dart';
import 'package:starter/common/utils/app_routes/router_functions.dart';
import 'package:starter/common/utils/common.dart';
import 'package:starter/common/utils/custom_widgets/application_app_bars.dart';
import 'package:starter/di/app_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/common/ui/custom_widgets/app_buttons/app_buttons.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/dimensions.dart';

class ResetPasswordPage extends StatelessWidget {
  final OtpVerificationInput input;
  static const String routeName = "ResetPasswordPage";

  const ResetPasswordPage({
    super.key,
    required this.input,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(
        injector(),
      ),
      child: PopScope(
        canPop: false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.neutral_0,
          extendBodyBehindAppBar: false,
          appBar: ApplicationAppBars.defaultAppBar(
              context: context,
              useCloseButton: true,
              onBackPressed: () {
                AppRouteNavigator.popUntil(context);
              }),
          body: _ResetPasswordBody(input: input),
        ),
      ),
    );
  }
}

class _ResetPasswordBody extends StatelessWidget {
  final OtpVerificationInput input;

  const _ResetPasswordBody({
    required this.input,
  });

  void onNewPasswordSuccess(BuildContext context, Async<String> verifyEmail) {
    showTopSnackSuccess(
        text: AuthenticationLocalizer.updatePasswordSuccess, context: context);
    AppRouteNavigator.popUntil(
      context,
      removeUntil: LoginPage.routeName,
    );
    // AlertSuccessDialog.showSuccessAlertDialog(context, () {
    //   AppRouteNavigator.popUntil(context, removeUntil: UserLoginPage.routeName);
    // },
    //     AuthenticationLocalizer.congratulations,
    //     AuthenticationLocalizer.updatePasswordSuccess,
    //     AuthenticationLocalizer.login);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state.resetPasswordState.isSuccess) {
          onNewPasswordSuccess(context, state.resetPasswordState);
        }
        if (state.resetPasswordState.isFailure) {
          showTopSnackError(
              text: state.resetPasswordState.errorMessage ?? "",
              context: context);
        }
      },
      child: SafeArea(
        child: Padding(
          padding: Dimensions.pageSmallMargins,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                HeaderWidget(
                    title: AuthenticationLocalizer.resetPassword,
                    description:
                        AuthenticationLocalizer.createPasswordDescription),
                const SizedBox(height: PaddingDimensions.x4Large),
                ResetPasswordForm(input: input),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResetPasswordForm extends StatefulWidget {
  final OtpVerificationInput input;

  const ResetPasswordForm({
    super.key,
    required this.input,
  });

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool whenTextIsEmpty = false;
  bool _isButtonEnabled = false;

  var _passwordObscured = true;
  var _confirmPasswordObscured = true;

  @override
  void initState() {
    _newPasswordController.addListener(() {
      _checkIfButtonEnabled();
    });
    _confirmPasswordController.addListener(() {
      _checkIfButtonEnabled();
    });
    super.initState();
  }

  void onEyePressed() {
    setState(() {
      _passwordObscured = !_passwordObscured;
    });
  }

  void onConfirmPasswordEyePressed() {
    setState(() {
      _confirmPasswordObscured = !_confirmPasswordObscured;
    });
  }

  void onSubmitPressed() {
    FocusScope.of(context).requestFocus(FocusNode());
    final bool isValidate = _formKey.currentState?.validate() ?? false;
    if (isValidate) {
      if (_isPasswordsSame()) {
        final UpdatePasswordInput input = UpdatePasswordInput(
            email: widget.input.email,
            newPassword: _newPasswordController.text,
            code: widget.input.verificationCode);

        BlocProvider.of<ResetPasswordCubit>(context).resetPassword(input);
      }
    }
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _checkIfButtonEnabled() {
    if (_newPasswordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty) {
      if (_isButtonEnabled == true) {
        return;
      }

      _isButtonEnabled = true;
    } else {
      _isButtonEnabled = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {},
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: PaddingDimensions.small,
            ),
            PasswordWidget(
              validator: (p0) {
                return null;
              },
              hintText: "",
              labelName: AuthenticationLocalizer.newPassword,
              controller: _newPasswordController,
              onChange: (text) {
                setState(() {});
              },
            ),
            const SizedBox(
              height: PaddingDimensions.large,
            ),
            PasswordWidget(
              validator: (p0) {
                return null;
              },
              hintText: "",
              labelName: AuthenticationLocalizer.confirmPassword,
              controller: _confirmPasswordController,
              onChange: (text) {
                setState(() {});
              },
            ),
            const SizedBox(
              height: PaddingDimensions.xxxLarge,
            ),
            BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
              builder: (context, state) {
                return AppButton.primaryButton(
                  title: AuthenticationLocalizer.next,
                  onPressed: _isButtonEnabled ? onSubmitPressed : null,
                  isLoading: state.resetPasswordState.isLoading,
                  isExpanded: true,
                );
              },
            ),
            const SizedBox(height: PaddingDimensions.large),
            const SizedBox(height: PaddingDimensions.large),
          ],
        ),
      ),
    );
  }

  bool _isPasswordsSame() {
    if (_newPasswordController.text != _confirmPasswordController.text) {
      showTopSnackError(
          text: AuthenticationLocalizer.passwordNotMatch, context: context);
      return false;
    }
    return true;
  }
}
