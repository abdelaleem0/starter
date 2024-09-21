import 'package:starter/app/authentication/domain/models/inputs/login_input.dart';
import 'package:starter/app/authentication/ui/complete_register/first_name/first_name_page.dart';
import 'package:starter/app/authentication/ui/forget_password/forget_password/forget_password_page.dart';
import 'package:starter/app/authentication/ui/login/manager/user_login_cubit.dart';
import 'package:starter/app/authentication/ui/login/manager/user_login_state.dart';
import 'package:starter/app/authentication/ui/register/sign_up_page.dart';
import 'package:starter/app/authentication/ui/widgets/already_have_account_widget.dart';
import 'package:starter/app/authentication/ui/widgets/email_widget.dart';
import 'package:starter/app/authentication/ui/widgets/password_widget.dart';
import 'package:starter/common/blocs/authentication/states.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import '../../../../../common/ui/header_widget.dart';
import 'package:starter/app/authentication/utils/localization/authentication_localizer.dart';
import 'package:starter/common/blocs/authentication/authentication_bloc.dart';
import 'package:starter/common/blocs/authentication/events.dart';
import 'package:starter/common/ui/custom_widgets/app_buttons/app_buttons.dart';
import 'package:starter/common/utils/app_routes/router_functions.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/common.dart';
import 'package:starter/common/utils/complete_checker_notifier.dart';
import 'package:starter/common/utils/custom_widgets/application_app_bars.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/localization/common_localizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static String routeName = "UserLoginPage";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserLoginCubit(),
      child: Scaffold(
        backgroundColor: AppColors.neutral_0,
        appBar: ApplicationAppBars.defaultAppBar(
          context: context,
          useCloseButton: true,
        ),
        extendBodyBehindAppBar: false,
        resizeToAvoidBottomInset: false,
        body: const _UserLoginBody(),
      ),
    );
  }
}

class _UserLoginBody extends StatefulWidget {
  const _UserLoginBody();

  @override
  State<_UserLoginBody> createState() => _UserLoginBodyState();
}

class _UserLoginBodyState extends State<_UserLoginBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  late CompleteCheckerNotifier _dataCompletedNotifier;

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

  void _onNextLoginPress() {
    if (_formKey.currentState?.validate() == true) {
      FocusScope.of(context).unfocus();
      final input = LoginInput(
        password: _passwordTextController.text,
        email: _emailTextController.text,
      );
      BlocProvider.of<UserLoginCubit>(context).userLoginFuc(
        input: input,
      );
    }
  }

  void _onLoginIsSuccess(UserLoginState state) {
    if (state.loginState.data?.isComplete == true) {
      BlocProvider.of<UserCubit>(context).setAppUserModel(
          state.loginState.data ??  AppUserModel.initial());
      BlocProvider.of<AuthenticationBloc>(context)
          .add(AuthenticatedEvent()); // will effect to above listener
    } else {
      AppRouteNavigator.push(
          context, FirstNamePage.routeName, const FirstNamePage());
    }
  }

  void _navigateToSignUpPage() {
    FocusNode().requestFocus();
    AppRouteNavigator.pushReplacement(context, SignUpPage.routeName, const SignUpPage());
  }

  void _navigateToForgetPasswordPage() {
    AppRouteNavigator.push(
      context,
      ForgetPasswordPage.routeName,
      const ForgetPasswordPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      child: BlocListener<UserLoginCubit, UserLoginState>(
        listener: (context, state) {
          if (state.loginState.isSuccess) {
            return _onLoginIsSuccess(state);
          }
          if (state.loginState.isFailure) {
            showTopSnackError(context: context, text: state.errorMessage ?? "");
          }
        },
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: PaddingDimensions.large),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: PaddingDimensions.xxLarge),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: PaddingDimensions.x4Large),
                  child: HeaderWidget(
                    title: AuthenticationLocalizer.login,
                    description:
                        'Get back to living a meaningful life of purpose',
                    descriptionColor: AppColors.authDescription,
                  ),
                ),
                const SizedBox(height: PaddingDimensions.x4Large),
                EmailWidget(
                  controller: _emailTextController,
                  onChange: (text) {
                    return _dataCompletedNotifier.checkIsDataCompleted();
                  },
                ),
                const SizedBox(
                  height: PaddingDimensions.xLarge,
                ),
                PasswordWidget(
                  controller: _passwordTextController,
                  onChange: (text) {
                    return _dataCompletedNotifier.checkIsDataCompleted();
                  },
                ),
                const SizedBox(
                  height: PaddingDimensions.xLarge,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: _navigateToForgetPasswordPage,
                      child: Text(
                        AuthenticationLocalizer.forgetPassword,
                        style: TextStyles.medium(
                            fontSize: Dimensions.xxLarge,
                            color: AppColors.forgetPass),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: PaddingDimensions.x5Large,
                ),
                BlocBuilder<UserLoginCubit, UserLoginState>(
                  builder: (context, state) {
                    return ValueListenableBuilder(
                      valueListenable: _dataCompletedNotifier,
                      builder: (context, value, child) {
                        return AppButton.primaryButton(
                            horizontalPadding: PaddingDimensions.x4Large,
                            isShadow: false,
                            isBold: false,
                            title: CommonLocalizer.next,
                            onPressed: value ? _onNextLoginPress : null,
                            isExpanded: true,
                            isLoading: state.loginState.isLoading,);
                      },
                    );
                  },
                ),
                const Spacer(),
                AlreadyOrDontHaveAccount(
                  text: AuthenticationLocalizer.dontHaveAnAccount,
                  clickableText: AuthenticationLocalizer.signUp,
                  onTap: _navigateToSignUpPage,
                ),
                const SizedBox(
                  height: PaddingDimensions.x6Large,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
