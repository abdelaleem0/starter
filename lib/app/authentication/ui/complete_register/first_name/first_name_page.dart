import 'package:starter/app/authentication/domain/models/inputs/complete_register_input.dart';
import 'package:starter/app/authentication/ui/complete_register/user_name/user_name_page.dart';
import 'package:starter/app/authentication/ui/social/auth_package_singlton/auth_package_singlton.dart';
import 'package:starter/app/authentication/ui/widgets/first_name_widget.dart';
import 'package:starter/common/blocs/authentication/authentication_bloc.dart';
import 'package:starter/common/blocs/authentication/events.dart';
import 'package:starter/common/blocs/authentication/states.dart';
import 'package:starter/common/utils/bottom_sheets/show_bottom_sheet_common.dart';
import 'package:starter/common/ui/custom_widgets/app_buttons/app_buttons.dart';
import 'package:starter/common/utils/app_routes/router_functions.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/complete_checker_notifier.dart';
import 'package:starter/common/utils/custom_widgets/application_app_bars.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/localization/common_localizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstNamePage extends StatefulWidget {
  static String routeName = "FirstNamePage";
  final bool isSocial;
  final bool checkLogout;

  const FirstNamePage({
    super.key,
    this.isSocial = false,
    this.checkLogout = false,
  });

  @override
  State<FirstNamePage> createState() => _FirstNamePageState();
}

class _FirstNamePageState extends State<FirstNamePage> {

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.neutral_0,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: ApplicationAppBars.defaultAppBar(
          onBackPressed: () {
            if (widget.checkLogout) {
              _showCheckLoggedBottomSheet(context);
            } else {
              AppRouteNavigator.popUntil(context);
            }
          },
          context: context,
          useCloseButton: true,
        ),
        body: SafeArea(
          child: _FirstNameBody(
              isSocial: widget.isSocial,
              checkLogout: widget.checkLogout,),
        ),
      ),
    );
  }
}

class _FirstNameBody extends StatefulWidget {
  final bool isSocial;
  final bool checkLogout;

  const _FirstNameBody(
      {required this.isSocial,
      required this.checkLogout,});

  @override
  State<_FirstNameBody> createState() => _FirstNameBodyState();
}

class _FirstNameBodyState extends State<_FirstNameBody> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  late CompleteCheckerNotifier _dataCompletedNotifier;

  bool isCompleteDataFilled() {
    return (_firstNameController.text.isNotEmpty);
  }

  @override
  void initState() {
    _dataCompletedNotifier = CompleteCheckerNotifier(
      () => isCompleteDataFilled(),
    );
    if (widget.isSocial == true) {
      final storedData =
          SocialAuthPackagesResultSingleton.instance?.packageData;
      if (storedData != null) {
        _firstNameController.text = storedData.firstName ?? '';
        _dataCompletedNotifier.checkIsDataCompleted();
      }
    }
    if (widget.checkLogout) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        _showCheckLoggedBottomSheet(context);
      });
    }
    super.initState();
  }



  @override
  void dispose() {
    _firstNameController.dispose();
    _dataCompletedNotifier.dispose();
    super.dispose();
  }

  void _onNextValidationPressed() {
    if (_formKey.currentState?.validate() == true) {
      FocusScope.of(context).unfocus();
      CompleteRegisterInput input = CompleteRegisterInput(
        firstName: _firstNameController.text.trim(),
      );
      AppRouteNavigator.push(
        context,
        UserNamePage.routeName,
        UserNamePage(
          completeRegisterInput: input,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthState>(
      listenWhen: (previous, current) => current is AuthUnauthenticated,
      listener: (context, state) {
        AppRouteNavigator.pop(context);
      },
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: PaddingDimensions.large),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: PaddingDimensions.xxLarge,
                ),

                const SizedBox(height: PaddingDimensions.x4Large),
                FirstNameWidget(
                  controller: _firstNameController,
                  onChange: (text) {
                    return _dataCompletedNotifier.checkIsDataCompleted();
                  },
                ),
                const SizedBox(
                  height: PaddingDimensions.xxLarge,
                ),
                ValueListenableBuilder(
                  valueListenable: _dataCompletedNotifier,
                  builder: (context, value, child) {
                    return AppButton.primaryButton(
                      horizontalPadding: PaddingDimensions.x4Large,
                      isShadow: false,
                      isBold: false,
                      fontSize: Dimensions.xxLarge,
                      title: CommonLocalizer.next,
                      onPressed: value ? _onNextValidationPressed : null,
                      isExpanded: true,
                      iconSize: 16,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
void _showCheckLoggedBottomSheet(context) async {
  await appBottomSheetConfirmOrBack(
    isDismissible: false,
    context: context,
    title: 'Complete your previous registration',
    description: 'You are already registered , do you want to continue or logout?',
    confirmButtonText: 'Continue',
    cancelText: 'Logout',
    onCancelClick: () {
      AuthenticationBloc.of(context).add(LoggedOutEvent());
    },
    onConfirmClick: () {
      AppRouteNavigator.pop(context);
    },
  );
}