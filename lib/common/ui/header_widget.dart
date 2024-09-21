import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final String description;
  final double? titleSize;
  final double? descriptionSize;
  final Color? titleColor;
  final Color? descriptionColor;
  final String? additionalText;
  final TextStyle? descriptionStyle;

  const HeaderWidget({
    super.key,
    required this.title,
    required this.description,
    this.titleSize,
    this.descriptionSize,
    this.titleColor,
    this.descriptionColor,
    this.additionalText,
    this.descriptionStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyles.semiBold(
            color: titleColor ?? AppColors.neutralColors7,
            fontSize: titleSize ?? Dimensions.smallDisplay,
          ),
        ),
        const SizedBox(
          height: PaddingDimensions.normal,
        ),
        (additionalText == null)
            ? Text(
                description,
                style: TextStyles.regular(
                  color: descriptionColor ?? AppColors.neutralColors7,
                  fontSize: descriptionSize ?? Dimensions.xLarge,
                ),
                textAlign: TextAlign.center,
              )
            : Text(
                "$description ($additionalText)",
                style: descriptionStyle??TextStyles.medium(
                  color: descriptionColor ?? AppColors.neutral_700,
                  fontSize: descriptionSize ?? Dimensions.xLarge,
                ),
                textAlign: TextAlign.center,
              )
      ],
    );
  }
}
