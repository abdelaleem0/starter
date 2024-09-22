import 'dart:io';
import 'package:starter/app/authentication/domain/models/social/social_provider_type.dart';
import 'package:starter/app/authentication/ui/login/login_page.dart';
import 'package:starter/app/authentication/ui/social/auth_package_singlton/auth_package_singlton.dart';
import 'package:starter/app/authentication/ui/social/social_auth_cubit.dart';
import 'package:starter/app/authentication/ui/social/social_auth_state.dart';
import 'package:starter/app/authentication/ui/widgets/social_button.dart';
import 'package:starter/app/authentication/utils/localization/authentication_localizer.dart';
import 'package:starter/app/authentication/utils/social_status_required_action_utils/social_status_required_action_utils.dart';
import 'package:starter/common/blocs/authentication/authentication_bloc.dart';
import 'package:starter/common/blocs/authentication/events.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import 'package:starter/common/ui/custom_widgets/app_progress/app_alert_loader.dart';
import 'package:starter/common/ui/custom_widgets/authentication_header.dart';
import '../../../../../common/ui/header_widget.dart';
import 'package:starter/common/utils/app_routes/router_functions.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/assets_paths/svg_paths.dart';
import 'package:starter/common/utils/common.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'provider_inherited_widget/provider_inherited_widget.dart';

class AuthenticationStartPage extends StatelessWidget {
  static String routeName = "AuthenticationStartPage";

  const AuthenticationStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialAuthCubit(),
      child: const _AuthenticationStartBody(),
    );
  }
}

class _AuthenticationStartBody extends StatefulWidget {
  const _AuthenticationStartBody();

  @override
  State<_AuthenticationStartBody> createState() =>
      _AuthenticationStartPageState();
}

class _AuthenticationStartPageState extends State<_AuthenticationStartBody> {
  final SocialStatusRequiredActionUtils _requiredActionUtils =
      SocialStatusRequiredActionUtils();
  SocialProviderTypeEnum? _providerType;

  @override
  Widget build(BuildContext context) {
    return ProviderInheritedWidget(
      provider: _providerType ?? SocialProviderTypeEnum.google,
      child: BlocListener<SocialAuthCubit, SocialAuthStates>(
        listenWhen: (previous, current) =>
            previous.logInStatusRequiredAction !=
            current.logInStatusRequiredAction,
        listener: (context, state) {
          if (state.logInStatusRequiredAction.isLoading) {
            AppAlertProgress.logo(context);
          }
          if (state.logInStatusRequiredAction.isFailure) {
            AppRouteNavigator.pop(context);
            showTopSnackError(
                text: state.logInStatusRequiredAction.errorMessage ?? '',
                context: context);
          }
          if (state.logInStatusRequiredAction.isSuccess) {
            final logInStatusData = state.logInStatusRequiredAction.data;
            // to close loader alert
            AppRouteNavigator.pop(context);
            if (logInStatusData?.appUserModel != null &&
                logInStatusData?.actionRequired == null) {
              SocialAuthPackagesResultSingleton.instance?.packageData =
                  logInStatusData?.packagesResult;
              BlocProvider.of<UserCubit>(context).setAppUserModel(
                  logInStatusData?.appUserModel ?? const AppUserModel.initial());
              _onSuccessUserLogged(
                  logInStatusData?.appUserModel ?? const AppUserModel.initial());
            } else {
              if (logInStatusData?.actionRequired != null) {
                SocialAuthPackagesResultSingleton.instance?.packageData =
                    logInStatusData?.packagesResult;
                _requiredActionUtils(
                  context,
                  requiredAction: logInStatusData!.actionRequired!,
                );
              }
            }
          }
        },
        child: WillPopScope(
          onWillPop: () async {
            AuthenticationBloc.of(context).add(AuthRestartEvent());
            return false;
          },

            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColors.neutralColors1,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(Dimensions.xLargeRadius),
                      ),
                      border: Border.all(
                          width: 1, color: AppColors.neutralColors1)),
                  child: SafeArea(
                    top: false,
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: PaddingDimensions.large),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const AuthenticationHeader(
                              backgroundColor: Colors.transparent,
                            ),
                            const SizedBox(
                              height: PaddingDimensions.large,
                            ),
                            HeaderWidget(
                                descriptionSize: Dimensions.xLarge,
                                title: AuthenticationLocalizer.welcomeAjmal,
                                description:
                                    AuthenticationLocalizer.welcomeMessage),
                            const SizedBox(
                              height: PaddingDimensions.xxLarge,
                            ),
                            if (Platform.isIOS) ...[
                              SocialButton(
                                borderColor: AppColors.neutralColors7,
                                icon: SvgPaths.apple,
                                text: AuthenticationLocalizer.continueWithApple,
                                bgColor: AppColors.neutral_0,
                                textColor: AppColors.blackColor,
                                iconColor: AppColors.blackColor,
                                onPress: () async {
                                  _socialLogInFun(SocialProviderTypeEnum.apple);
                                  setState(() {
                                    _providerType =
                                        SocialProviderTypeEnum.apple;
                                  });
                                },
                              ),
                            ],
                            SocialButton(
                              borderColor: AppColors.neutralColors7,
                              textColor: Colors.black,
                              bgColor: AppColors.neutral_0,
                              icon: SvgPaths.google,
                              text: AuthenticationLocalizer.continueWithGoogle,
                              onPress: () async {
                                _socialLogInFun(SocialProviderTypeEnum.google);
                                setState(() {
                                  _providerType = SocialProviderTypeEnum.google;
                                });
                              },
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: PaddingDimensions.xLarge),
                                child: Text(
                                  AuthenticationLocalizer.oR,
                                  style: TextStyles.regular(
                                      color: AppColors.defaultGray,
                                      fontSize: Dimensions.large),
                                ),
                              ),
                            ),
                            SocialButton(
                              borderColor: AppColors.neutralColors1,
                              iconSize: Dimensions.xxxxxLarge,
                              bgColor: AppColors.primaryColorsSolid4Default,
                              icon: SvgPaths.email,
                              iconColor: AppColors.neutralColors1,
                              textColor: AppColors.neutralColors1,
                              text: AuthenticationLocalizer.continueWithEmail,
                              onPress: _continueWithEmailFun,
                            ),
                            const SizedBox(height: PaddingDimensions.x4Large),
                            const SizedBox(height: PaddingDimensions.medium),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

        ),
      ),
    );
  }

  void _continueWithEmailFun() =>
      AppRouteNavigator.push(context, LoginPage.routeName, const LoginPage());

  void _onSuccessUserLogged(AppUserModel appUserModel) {
    if (appUserModel.isFirstRegistration) {
      if (appUserModel.isComplete) {
        AuthenticationBloc.of(context).add(IsFirstRegistrationEvent());
      } else {
        AuthenticationBloc.of(context)
            .add(const AuthFirstNameEvent(checkLogout: true));
      }
    } else {
      AuthenticationBloc.of(context).add(AuthenticatedEvent());
    }
  }

  void _socialLogInFun(SocialProviderTypeEnum provider) {
    SocialAuthCubit.of(context).logInStatusRequiredAction(provider);
  }
}
