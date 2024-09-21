import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';

class IconsButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isBold;
  final Color? textColor;
  final Color? backgroundColor;
  final double horizontalPadding;
  final double verticalPadding;
  final double? cornerRadius;
  final double borderWidth;
  final Color? borderColor;
  final double? buttonHeight;
  final IconData? buttonIcon;
  final double? iconSize;
  final bool isLoading;
  final List<Color>? gradiantColors;
  final double? fontSize;
  final bool verifyIcon;
  final bool isShadow;
  final Color? color;
  final bool isExpanded;
  final TextStyle? textStyle;
  final Widget? actionWidget;
  final BoxShadow? buttonShadow;
  final Widget? iconImageAssets;
  final double? buttonWidth;
  final AlignmentGeometry? alignment;

  const IconsButton(
      {super.key,
        required this.onPressed,
        this.isBold = true,
        this.textColor,
        this.backgroundColor,
        this.horizontalPadding = 48,
        this.verticalPadding = 8,
        this.cornerRadius,
        this.borderWidth = 0,
        this.borderColor,
        this.buttonHeight,
        this.buttonWidth,
        this.buttonIcon,
        this.iconSize,
        this.isLoading = false,
        this.gradiantColors,
        this.fontSize,
        this.verifyIcon = false,
        this.isShadow = true,
        this.color,
        this.isExpanded = false,
        this.textStyle,
        this.actionWidget,
        this.buttonShadow,
        this.iconImageAssets,
        this.alignment});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? AlignmentDirectional.centerStart,
      child: GestureDetector(
        onTap: isLoading ? () {} : onPressed,
        child: Container(
            height: buttonHeight,
            width: buttonWidth,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
              gradient: gradiantColors == null
                  ? null
                  : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: gradiantColors!,
              ),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              minRadius: 10,
              maxRadius: iconSize ?? 30,
              child: Icon(
                buttonIcon,
                color: color ?? AppColors.neutral_900,
                size: iconSize ?? IconDimensions.small,
              ),
            )),
      ),
    );
  }

  static IconsButton iconButton({
    required VoidCallback onPressed,
    bool isLoading = false,
    double horizontalPadding = 48,
    double verticalPadding = 0,
    double? buttonHeight,
    Color? color,
    Color? borderColor,
    IconData? buttonIcon,
    final List<Color>? gradiantColors,
    Color? textColor,
    double? fontSize,
    double? cornerRadius,
    bool? verifyIcon,
    bool isBold = false,
    bool isShadow = true,
    bool? isExpanded,
    double? borderWidth,
    TextStyle? textStyle,
    double? iconSize,
    Widget? actionWidget,
    BoxShadow? buttonShadow,
  }) {
    return IconsButton(
      borderWidth: borderWidth ?? 0,
      isShadow: isShadow,
      borderColor: borderColor ?? AppColors.borderColor,
      gradiantColors: gradiantColors ?? AppColors.buttonDefaultGradiantColors,
      fontSize: fontSize,
      onPressed: onPressed,
      cornerRadius: cornerRadius ?? 24,
      isBold: isBold,
      textColor: textColor ?? AppColors.textForthColor,
      isLoading: isLoading,
      horizontalPadding: horizontalPadding,
      verticalPadding: verticalPadding,
      buttonHeight: buttonHeight ?? Dimensions.buttonHeight,
      buttonIcon: buttonIcon,
      iconSize: iconSize,
      verifyIcon: verifyIcon ?? false,
      color: color,
      isExpanded: isExpanded ?? false,
      textStyle: textStyle,
      actionWidget: actionWidget,
      buttonShadow: buttonShadow,
    );
  }
}
