import 'package:starter/app/authentication/domain/models/social/merge/social_merge_input.dart';
import 'package:starter/app/authentication/mappers/social/map_social_auth_packages_result_to_social_merge_input.dart';
import 'package:starter/app/authentication/ui/social/auth_package_singlton/auth_package_singlton.dart';
import 'package:starter/app/authentication/ui/social/merge/social_merge_cubit.dart';
import 'package:starter/app/authentication/ui/social/merge/social_merge_state.dart';
import 'package:starter/common/blocs/authentication/authentication_bloc.dart';
import 'package:starter/common/blocs/authentication/events.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import 'package:starter/common/ui/custom_widgets/app_buttons/app_buttons.dart';
import 'package:starter/common/ui/custom_widgets/app_icons/app_icon.dart';
import 'package:starter/common/ui/custom_widgets/app_progress/app_alert_loader.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/assets_paths/svg_paths.dart';
import 'package:starter/common/utils/bottom_sheets/show_bottom_sheet_common.dart';
import 'package:starter/common/utils/common.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/localization/common_localizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialMergeBottomSheet extends StatelessWidget {
  final String title;
  final String description;
  final String confirmButtonText;
  final String? cancelText;
  final String? socialIcon;


  const SocialMergeBottomSheet({
    super.key,
    required this.title,
    required this.description,
    required this.confirmButtonText,
    this.cancelText,
    this.socialIcon,
  });

  static openBottomSheet({
    String? title,
    String? description,
    String? confirmButtonText,
    String? cancelText,
    String? socialIcon,
    context,
  }) async {
    return await appBottomSheetCommon(
      context,
      builder: (context) {
        return BlocProvider(
          create: (context) => SocialMergeCubit(),
          child: SocialMergeBottomSheet(
            title: title ?? '',
            description: description ?? '',
            confirmButtonText: confirmButtonText ?? '',
            cancelText: cancelText ?? CommonLocalizer.cancel,
            socialIcon: socialIcon ?? SvgPaths.google,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _SocialMergePageBody(
      title: title,
      description: description,
      confirmButtonText: confirmButtonText,
      cancelText: cancelText ?? CommonLocalizer.cancel,
      socialIcon: socialIcon ?? SvgPaths.google,
    );
  }
}

class _SocialMergePageBody extends StatelessWidget {
  final String title;
  final String description;
  final String confirmButtonText;
  final String cancelText;
  final String socialIcon;

  _SocialMergePageBody({
    required this.title,
    required this.description,
    required this.confirmButtonText,
    required this.cancelText,
    required this.socialIcon,
  });

  final authPackagesResult =
      SocialAuthPackagesResultSingleton.instance?.packageData;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SocialMergeCubit, SocialMergeState>(
      listenWhen: (previous, current) =>
          previous.mergeState != current.mergeState,
      listener: (context, state) {
        if (state.mergeState.isLoading) {
          AppAlertProgress.logo(context);
        }
        if (state.mergeState.isFailure) {
          showTopSnackError(
              context: context, text: state.mergeState.errorMessage ?? '');
          Navigator.pop(context);
        }
        if (state.mergeState.isSuccess) {
          BlocProvider.of<UserCubit>(context)
              .setAppUserModel(state.mergeState.data ?? AppUserModel.initial());
          _onSuccessUserLogged(context);
        }
      },
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: PaddingDimensions.medium,
            ),
            AppIcons(
              imagePath: socialIcon,
              height: 56,
              width: 56,
            ),
            const SizedBox(
              height: PaddingDimensions.xLarge,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyles.semiBold(
                color: AppColors.neutralColors7,
                fontSize: Dimensions.xxxxLarge,
              ),
            ),
            const SizedBox(height: PaddingDimensions.normal),
            Text(
              textAlign: TextAlign.center,
              description,
              style: TextStyles.regular(
                color: AppColors.neutralColors7,
                fontSize: Dimensions.xLarge,
              ),
            ),
            const SizedBox(
              height: PaddingDimensions.x4Large,
            ),
            AppButton.primaryButton(
                buttonHeight: Dimensions.buttonHeight,
                onPressed: () {
                  if (authPackagesResult != null) {
                    _onAccept(context,
                        input: authPackagesResult!.mapToMergeInput());
                  }
                },
                isExpanded: true,
                title: confirmButtonText),
            const SizedBox(
              height: PaddingDimensions.large,
            ),
            AppButton.outlinedButton(
                buttonHeight: Dimensions.buttonHeight,
                isExpanded: true,
                onPressed: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
                title: cancelText),
            const SizedBox(
              height: PaddingDimensions.xxLarge,
            )
          ],
        ),
      ),
    );
  }

  void _onSuccessUserLogged(context) {
    AuthenticationBloc.of(context).add(AuthenticatedEvent());
    Navigator.of(context).popUntil(
      (route) => route.isFirst,
    );
  }

  void _onAccept(context, {required SocialMergeInput input}) =>
      SocialMergeCubit.of(context).merge(input);
}
