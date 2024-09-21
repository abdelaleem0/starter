import 'package:starter/app/authentication/domain/models/inputs/complete_register_input.dart';
import 'package:starter/app/authentication/ui/complete_register/profile_picture/profile_picture_page.dart';
import 'package:starter/app/authentication/ui/complete_register/user_name/user_name_cubit.dart';
import 'package:starter/app/authentication/ui/complete_register/user_name/user_name_state.dart';
import 'package:starter/common/ui/custom_widgets/app_text_fields/app_text_field_tile.dart';
import 'package:starter/common/ui/custom_widgets/app_text_fields/app_text_form_field.dart';
import 'package:starter/common/ui/custom_widgets/app_text_fields/format/input_formatters_TextFormField.dart';
import 'package:starter/app/authentication/utils/localization/authentication_localizer.dart';
import 'package:starter/common/ui/custom_widgets/app_buttons/app_buttons.dart';
import 'package:starter/common/utils/app_routes/router_functions.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/common.dart';
import 'package:starter/common/utils/custom_widgets/application_app_bars.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserNamePage extends StatelessWidget {
  static String routeName = "UserNamePage";
  final CompleteRegisterInput completeRegisterInput;

  const UserNamePage(
      {super.key, required this.completeRegisterInput,});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserNameCubit(),
      child: Scaffold(
        appBar: ApplicationAppBars.defaultAppBar(
          context: context,
          useCloseButton: true,
        ),
        backgroundColor: AppColors.neutral_0,
        extendBodyBehindAppBar: false,
        body: SafeArea(
          child: UserNameBody(
            completeRegisterInput: completeRegisterInput,
          ),
        ),
      ),
    );
  }
}

class UserNameBody extends StatefulWidget {
  final CompleteRegisterInput completeRegisterInput;

  const UserNameBody(
      {super.key, required this.completeRegisterInput,});

  @override
  State<UserNameBody> createState() => _UserNameBodyState();
}

class _UserNameBodyState extends State<UserNameBody> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  String? selectedUserName;
  late CompleteRegisterInput _completeRegisterInput;

  @override
  void initState() {
    _completeRegisterInput = widget.completeRegisterInput;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserNameCubit, UserNameState>(
      buildWhen: (previous, current) =>
          current.isUserNameExists != previous.isUserNameExists,
      listenWhen: (previous, current) =>
          previous.isUserNameExists != current.isUserNameExists,
      listener: (context, state) {
        if (state.isUserNameExists.isSuccess) {
          _doIfUsernameIsNotExist();
        } else if (state.isUserNameExists.isFailure) {
          showTopSnackError(
              context: context,
              text: state.isUserNameExists.errorMessage ?? "");
        }
      },
      builder: (context, state) {
        return Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: PaddingDimensions.large),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: PaddingDimensions.xxLarge,
                  ),
                  const SizedBox(height: PaddingDimensions.x4Large),
                  AppTextFieldTile(
                    contentPadding:
                        const EdgeInsets.all(PaddingDimensions.large),
                    textFieldType: TextFieldType.normal,
                    borderColor: AppColors.neutralColors3,
                    label: AuthenticationLocalizer.createUsername,
                    hintText: AuthenticationLocalizer.userName,
                    onchange: (p0) {
                      setState(() {
                        selectedUserName = _userNameController.text;
                      });
                    },
                    inputFormatters: [
                      NoStartWithSpaceFormatter(),
                      // FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\d_]")),
                    ],
                    textDirection: TextDirection.ltr,
                    controller: _userNameController,
                    maxErrorLines: 2,
                    validator: (text) {
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: PaddingDimensions.xxLarge,
                  ),
                  BlocBuilder<UserNameCubit, UserNameState>(
                    builder: (context, state) {
                      return AppButton.primaryButton(
                        horizontalPadding: PaddingDimensions.x4Large,
                        isShadow: false,
                        isBold: false,
                        fontSize: Dimensions.xxLarge,
                        title: AuthenticationLocalizer.next,
                        onPressed: _userNameController.text.isEmpty
                            ? null
                            : onPressedValidation,
                        isExpanded: true,
                        isLoading: state.isUserNameExists.isLoading,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void onPressedValidation() async {
    int numberInText = 0;
    String text = _userNameController.text;
    String allNumber = "0123456789";

    text.split('').forEach((element) {
      if (allNumber.contains(element) == true) {
        numberInText++;
      }
    });
    if (text.isEmpty) {
      showTopSnackError(
          context: context, text: AuthenticationLocalizer.usernameEmptyError);
    } else if (text.length < 4) {
      showTopSnackError(
          context: context,
          text: AuthenticationLocalizer.minimumUserCharacters);
    } else if (text.contains(RegExp(r"[^\w\s]"))) {
      showTopSnackError(
          context: context, text: AuthenticationLocalizer.usernameError4);
    } else if (!text.startsWith(RegExp(r"^[A-Za-z]"))) {
      showTopSnackError(
          context: context, text: AuthenticationLocalizer.usernameError3);
    } else if (text.contains(RegExp("\\s+"))) {
      showTopSnackError(
          context: context, text: AuthenticationLocalizer.usernameError2);
    } else if (text.length > 16) {
      showTopSnackError(
          context: context,
          text: AuthenticationLocalizer.maximumUserCharacters);
    } else {
      FocusScope.of(context).unfocus();
      _isUserNameExists();
    }
  }

  void _isUserNameExists() {
    context.read<UserNameCubit>().setUserNameStateToInitial();
    context
        .read<UserNameCubit>()
        .checkUsernameExists(userName: _userNameController.text);
  }

  void _doIfUsernameIsNotExist() {
    _completeRegisterInput = _completeRegisterInput.modify(
      userName: _userNameController.text,
    );
      AppRouteNavigator.push(
        context,
        UploadUserPicturePage.routeName,
        UploadUserPicturePage(
            completeRegisterInput: _completeRegisterInput,),
      );
    }
}
