import 'package:starter/common/ui/custom_widgets/app_buttons/app_material_buttons.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CustomButtonRow extends StatelessWidget {
  final String leftButtonText;
  final Color leftButtonColor;
  final Color? leftBorderColor;
  final TextStyle? leftButtonTextStyle;
  final VoidCallback onLeftButtonPressed;

  final String rightButtonText;
  final Color rightButtonColor;
  final Color? rightBorderColor;
  final TextStyle? rightButtonTextStyle;
  final VoidCallback onRightButtonPressed;

  const CustomButtonRow({
    super.key,
    required this.leftButtonText,
    required this.leftButtonColor,
    this.leftBorderColor,
    this.leftButtonTextStyle,
    required this.onLeftButtonPressed,
    required this.rightButtonText,
    required this.rightButtonColor,
    this.rightBorderColor,
    this.rightButtonTextStyle,
    required this.onRightButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: PaddingDimensions.xLarge),
      child: Row(
        children: [
          Expanded(
            child: AppMaterialButtons.primaryButton(
              text: leftButtonText,
              buttonColor: leftButtonColor,
              borderColor: leftBorderColor,
              textStyle: leftButtonTextStyle ??
                  TextStyles.medium(
                    color: AppColors.primary_400,
                    fontSize: Dimensions.xxLarge,
                  ),
              borderRadius: 24,
              onPressed: onLeftButtonPressed,
              padding: const EdgeInsets.all(PaddingDimensions.medium),
            ),
          ),
          const SizedBox(width: PaddingDimensions.large),
          Expanded(
            child: AppMaterialButtons.primaryButton(
              text: rightButtonText,
              buttonColor: rightButtonColor,
              borderColor: rightBorderColor,
              textStyle: rightButtonTextStyle ??
                  TextStyles.medium(
                    color: AppColors.neutral_0,
                    fontSize: Dimensions.xxLarge,
                  ),
              borderRadius: 24,
              padding: const EdgeInsets.all(PaddingDimensions.medium),
              onPressed: onRightButtonPressed,
            ),
          ),
        ],
      ),
    );
  }
}
