import 'package:starter/app/authentication/domain/models/social/social_provider_type.dart';
import 'package:starter/app/authentication/mappers/social/map_social_auth_packages_result_to_social_check_provider_status.dart';
import 'package:starter/app/authentication/ui/social/auth_package_singlton/auth_package_singlton.dart';
import 'package:starter/app/authentication/ui/social/email_page/social_email_page_state.dart';
import 'package:starter/app/authentication/ui/widgets/email_widget.dart';
import 'package:starter/common/ui/custom_widgets/app_buttons/app_buttons.dart';
import 'package:starter/common/ui/custom_widgets/authentication_header.dart';
import '../../../../../common/ui/header_widget.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/common.dart';
import 'package:starter/common/utils/custom_widgets/application_app_bars.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/localization/common_localizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/models/social/check_provider_status/social_check_provider_status_input.dart';
import '../../../domain/models/social/check_provider_status/social_register_response_required_action.dart';
import '../../../utils/localization/authentication_localizer.dart';
import '../../../utils/social_status_required_action_utils/social_status_required_action_utils.dart';
import 'social_email_page_cubit.dart';

class SocialEmailPage extends StatelessWidget {
  static String routeName = "SocialEmailPage";
  const SocialEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialEmailPageCubit(),
      child:  const _SocialEmailPageBody(),
    );
  }
}

class _SocialEmailPageBody extends StatefulWidget {
  const _SocialEmailPageBody();

  @override
  State<_SocialEmailPageBody> createState() => _SocialEmailPageBodyState();
}

class _SocialEmailPageBodyState extends State<_SocialEmailPageBody> {
  final SocialStatusRequiredActionUtils _requiredActionUtils =
      SocialStatusRequiredActionUtils();

  String? _emailAddress;
  final _providerData = SocialAuthPackagesResultSingleton.instance?.packageData;
  final formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral_0,
      appBar: ApplicationAppBars.defaultAppBar(
        context: context, title: '',
        useCloseButton: true,
      ),
      body: BlocConsumer<SocialEmailPageCubit, SocialEmailPageState>(
        listener: (context, state) {
          if (state.checkStatus.isSuccess) {
            if (state.checkStatus.data != null) {
              _onSuccess(state.checkStatus.data!);
            }
          }
          if(state.checkStatus.isFailure){
            showTopSnackError(text: state.checkStatus.errorMessage ?? '',
                context: context);
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: PaddingDimensions.large),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AuthenticationHeader(),
                    const SizedBox(height: PaddingDimensions.normal,),
                    HeaderWidget(
                      title: AuthenticationLocalizer.withWord, description: AuthenticationLocalizer.socialEmailDescription,
                    ),
                    const SizedBox(height: PaddingDimensions.normal,),
                    const SizedBox(
                      height: PaddingDimensions.large - 4,
                    ),
                    EmailWidget(
                      onChange:_onEmailAddressChange,
                    ),
                    const SizedBox(
                      height: PaddingDimensions.large,
                    ),
                    AppButton.primaryButton(
                      title: CommonLocalizer.continueText,
                      isLoading: state.checkStatus.isLoading,
                      onPressed: () {
                        _verifyEmail();
                      },
                      isExpanded: true,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onSuccess(SocialProviderStatusRequiredActionEnum requiredAction) {
    final SocialAuthPackagesResultSingleton? data =
        SocialAuthPackagesResultSingleton.instance;
    if (data != null) {
      data.actionRequired = requiredAction;
      data.packageData = data.packageData
          ?.modify(email: _emailAddress ?? '', isEmailManuallyEntered: true);
      _requiredActionUtils(context,
          requiredAction: requiredAction, email: _emailAddress,);
    }
  }

  void _verifyEmail() {
    final bool isValidate = formKey.currentState?.validate() ?? false;
    if(isValidate){
      if (_emailAddress != null && _emailAddress != '' && _providerData != null) {
        SocialCheckProviderStatusInput input = _providerData!
            .modify(email: _emailAddress, isEmailManuallyEntered: true)
            .mapToProviderStatusInput();
        SocialEmailPageCubit.of(context).checkStatus(input);
      }
    }
  }

  void _onEmailAddressChange(String text) {
    _emailAddress = text;
    setState(() {});
  }

  String getSocialText(SocialProviderTypeEnum? provider) {
    switch (provider) {
      // case SocialProviderTypeEnum.facebook:
      //   return AuthenticationLocalizer.facebook;
      // case SocialProviderTypeEnum.twitter:
      //   return AuthenticationLocalizer.twitter;
      case SocialProviderTypeEnum.google:
        return AuthenticationLocalizer.google;
      case SocialProviderTypeEnum.apple:
        return AuthenticationLocalizer.apple;
      default:
        return AuthenticationLocalizer.facebook;
    }
  }
}
