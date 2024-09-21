import 'dart:io';
import 'package:starter/app/authentication/domain/models/inputs/complete_register_input.dart';
import 'package:starter/app/authentication/ui/complete_register/profile_picture/profile_picture_cubit.dart';
import 'package:starter/app/authentication/ui/complete_register/profile_picture/profile_picture_state.dart';
import 'package:starter/common/blocs/authentication/authentication_bloc.dart';
import 'package:starter/common/blocs/authentication/events.dart';
import 'package:starter/common/blocs/authentication/states.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import 'package:starter/common/ui/custom_widgets/app_icons/app_icon.dart';
import 'package:starter/app/authentication/utils/localization/authentication_localizer.dart';
import 'package:starter/common/ui/custom_widgets/app_buttons/app_buttons.dart';
import 'package:starter/common/utils/app_routes/router_functions.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/assets_paths/svg_paths.dart';
import 'package:starter/common/utils/bottom_sheets/media_picker_bottom_sheet/media_picker_bottom_sheet.dart';
import 'package:starter/common/utils/bottom_sheets/show_bottom_sheet_common.dart';
import 'package:starter/common/utils/common.dart';
import 'package:starter/common/utils/custom_widgets/application_app_bars.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/localization/common_localizer.dart';
import 'package:starter/common/utils/media_utils/src/domain/models/attachment_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadUserPicturePage extends StatelessWidget {
  static String routeName = "UploadUserPicturePage";
  final CompleteRegisterInput completeRegisterInput;

  const UploadUserPicturePage({
    super.key,
    required this.completeRegisterInput,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfilePictureCubit(),
      child: _UploadUserPictureBody(
        completeRegisterInput: completeRegisterInput,
      ),
    );
  }
}

class _UploadUserPictureBody extends StatefulWidget {
  final CompleteRegisterInput completeRegisterInput;

  const _UploadUserPictureBody({
    required this.completeRegisterInput,});

  @override
  State<_UploadUserPictureBody> createState() => __UploadUserPictureBodyState();
}

class __UploadUserPictureBodyState extends State<_UploadUserPictureBody> {


  void _onSkipPress(BuildContext context) {
    context.read<ProfilePictureCubit>().completeRegister(
          widget.completeRegisterInput.modify(profilePicture: null),);
  }

  Attachment? _userPicture;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfilePictureCubit, ProfilePictureState>(
      listener: (context, state) {
        if (state.completeRegisterState.isSuccess) {
          BlocProvider.of<UserCubit>(context).setAppUserModel(
              state.completeRegisterState.data ?? AppUserModel.initial());
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AppEnableBiometricEvent());
        }  if (state.completeRegisterState.isFailure) {
          showTopSnackError(
              context: context,
              text: state.completeRegisterState.errorMessage ?? "");
        }
      },
      child: BlocListener<AuthenticationBloc, AuthState>(
        listenWhen: (previous, current) =>
            current is AuthEnabledBiometricAuthenticated,
        listener: (context, state) {
          AppRouteNavigator.popUntil(context);
          //todo :this to hide the screens appearance in poops
          //todo : this not right
          // AppRouteNavigator.push(context, BuilderScreen.routeName, const BuilderScreen());
          // AppRouteNavigator.pushAndRemoveUntil(
          //     context, BuilderScreen.routeName, const BuilderScreen());
        },
        child: BlocListener<AuthenticationBloc, AuthState>(
          listenWhen: (previous, current) => current is AuthUnauthenticated,
          listener: (context, state) {
            AppRouteNavigator.pop(context);
          },
          child: Scaffold(
            backgroundColor: AppColors.neutral_0,
            extendBodyBehindAppBar: true,
            appBar: ApplicationAppBars.defaultAppBar(
              context: context,
              useCloseButton: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: PaddingDimensions.large,
                      vertical: PaddingDimensions.normal),
                  child: GestureDetector(
                    onTap: () => _onSkipPress(context),
                    child: Text(
                      "Skip",
                      style: TextStyles.medium(
                          color: AppColors.primaryColorsSolid4Default),
                    ),
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: PaddingDimensions.large),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: PaddingDimensions.xxLarge,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: PaddingDimensions.xxxLarge,
                          ),
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 88,
                                backgroundColor: _userPicture == null
                                    ? AppColors.neutralColors2
                                    : Colors.transparent,
                                backgroundImage: _userPicture != null
                                    ? FileImage(File(_userPicture?.url ?? ""))
                                    : null,
                                child: _userPicture == null
                                    ? const FittedBox(
                                        fit: BoxFit.contain,
                                        clipBehavior: Clip.antiAlias,
                                        child: AppIcons(
                                          imagePath: SvgPaths.person,
                                        ))
                                    : null,
                              ),
                              if (_userPicture != null) ...[
                                PositionedDirectional(
                                  bottom: 0,
                                  end: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      _addPicturePressed();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.neutralColors1,
                                            width: 1.7),
                                        shape: BoxShape.circle,
                                        color: AppColors.primaryColorsSolid7,
                                      ),
                                      width: 56,
                                      height: 56,
                                      child: const Padding(
                                        padding: EdgeInsets.all(
                                            PaddingDimensions.normal),
                                        child: AppIcons(
                                          // Iconsax.edit_24,
                                          color: AppColors
                                              .primaryColorsSolid4Default,
                                          imagePath: SvgPaths.editProfile,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ]
                            ],
                          ),
                        ),
                        BlocBuilder<ProfilePictureCubit, ProfilePictureState>(
                            builder: (context, state) {
                          return AppButton.primaryButton(
                            isLoading: (state.completeRegisterState.isLoading),
                            horizontalPadding: PaddingDimensions.x4Large,
                            isShadow: false,
                            isBold: false,
                            fontSize: Dimensions.xxLarge,
                            title: _userPicture == null
                                ? CommonLocalizer.addPicture
                                : CommonLocalizer.next,
                            onPressed: () {
                              if (_userPicture == null) {
                                _addPicturePressed();
                              } else {
                                _savePressed();
                              }
                            },
                            isExpanded: true,
                            iconSize: 16,
                          );
                        }),
                      ],
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

  void _onRemoveImageCallback() {
    setState(() {
      _userPicture = null;
      AppRouteNavigator.pop(context);
    });
  }

  void _addPicturePressed() {
    showMediaPickerUtilsBottomSheet(
      pageContext: context,
      canModifyImage: true,
      isRemovable: _userPicture == null ? false : true,
      types: [
        MediaPickType.pickGalleryImage,
        MediaPickType.pickCameraImage,
      ],
      onPickMedia: (media) {
        setState(() {
          _userPicture = null;
          _userPicture = media;
        });
      },
      onRemove: _onRemoveImageCallback,
    );
  }

  void _savePressed() {
      FocusScope.of(context).unfocus();
      final CompleteRegisterInput userData =
          widget.completeRegisterInput.modify(
        profilePicture: _userPicture,
      );
      BlocProvider.of<ProfilePictureCubit>(context).completeRegister(userData);
    }
}
