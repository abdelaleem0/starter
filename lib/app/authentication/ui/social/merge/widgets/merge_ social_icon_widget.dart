// ignore_for_file: file_names

import 'package:starter/common/ui/custom_widgets/app_icons/app_icon.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/assets_paths/svg_paths.dart';
import 'package:flutter/material.dart';
import '../../../../domain/models/social/social_provider_type.dart';

class MergeSocialIconWidget extends StatelessWidget {
  const MergeSocialIconWidget({super.key, required this.type});

  final SocialProviderTypeEnum type;
  @override
  Widget build(BuildContext context) {
    switch (type) {
      // case SocialProviderTypeEnum.facebook:
      //   return const AppIcons(
      //       imagePath: IconsPaths.facebook,
      //       color: AppColors.blueColor,
      //       height: 65);
      // case SocialProviderTypeEnum.twitter:
      //   return const AppIcons(
      //       imagePath: IconsPaths.twitter,
      //       color: AppColors.blueSkyColor,
      //       height: 65);
      case SocialProviderTypeEnum.google:
        return const AppIcons(imagePath: SvgPaths.google, height: 65);
      case SocialProviderTypeEnum.apple:
        return const AppIcons(
            imagePath: SvgPaths.apple,
            color: AppColors.blackColor,
            height: 65);
    }
  }
}
