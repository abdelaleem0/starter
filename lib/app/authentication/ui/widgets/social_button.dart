import 'package:starter/common/ui/custom_widgets/app_icons/app_icon.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  const SocialButton(
      {super.key,
      this.bgColor,
      this.iconColor,
      this.textColor,
      this.borderColor,
      this.iconSize,
      required this.icon,
      required this.text,
      required this.onPress});

  final VoidCallback onPress;
  final String text;
  final String icon;
  final Color? bgColor;
  final Color? iconColor;
  final Color? textColor;
  final Color? borderColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: Dimensions.buttonHeight,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: PaddingDimensions.small),
        alignment: Alignment.center,
        // padding: const EdgeInsets.symmetric(
        //   horizontal: PaddingDimensions.xLarge,
        // ),
        decoration: BoxDecoration(
            color: bgColor ?? AppColors.forthColor,
            borderRadius: const BorderRadius.all(Radius.circular(Dimensions.xxLargeRadius)),
            border: Border.all(width: 1, color: borderColor ??AppColors.neutral_100)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcons(
                size:iconSize?? Dimensions.xxLarge,
                imagePath: icon,
                color: iconColor,
              ),
              const SizedBox(
                width: PaddingDimensions.normal,
              ),
              Text(
                text,
                style: TextStyles.regular(
                  fontSize: Dimensions.xxLarge,
                  color: textColor ?? AppColors.primary_300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
