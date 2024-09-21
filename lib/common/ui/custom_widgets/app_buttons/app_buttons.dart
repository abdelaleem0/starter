import 'package:flutter/material.dart';

import 'package:starter/common/ui/custom_widgets/switched_widget.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/dimensions.dart';

import '../../../utils/app_style/text_styles.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final bool isBold;
  final Color? textColor;
  final Color? backgroundColor;
  final double horizontalPadding;
  final double verticalPadding;
  final double? cornerRadius;
  final double borderWidth;
  final bool iconBeforeText;
  final Color? borderColor;
  final double buttonHeight;
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
  final BoxShadow? buttonShadow;
  final bool? isGradientDefault;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  const AppButton({
    super.key,
    required this.title,
    this.onPressed,
    this.isBold = true,
    this.textColor,
    this.backgroundColor,
    this.horizontalPadding = 48,
    this.iconBeforeText = false,
    this.verticalPadding = 8,
    this.cornerRadius,
    this.borderWidth = 0,
    this.borderColor,
    double? buttonHeight,
    double? buttonWidth = 16,
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
    this.buttonShadow,
    this.suffixIcon,
    this.prefixIcon,
    this.isGradientDefault = true,
  })  : buttonHeight = buttonHeight ?? Dimensions.buttonHeight;

  @override
  Widget build(BuildContext context) {
    final shouldShowIcon = buttonIcon != null;
    return Stack(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            height: buttonHeight,
            decoration: BoxDecoration(
              // color: backgroundColor?.withOpacity(0.96),
              color: (onPressed == null)
                  ? AppColors.defaultBorderField
                  : backgroundColor,
              borderRadius: BorderRadius.circular(cornerRadius ?? 4),
              border: Border.all(
                  color: borderColor ?? Colors.transparent, width: borderWidth),
              boxShadow: isShadow
                  ? [
                      buttonShadow == null
                          ? BoxShadow(
                              color: AppColors.primaryColor.withOpacity(0.15),
                              blurRadius: 15.0,
                              offset: const Offset(5, 18),
                            )
                          : buttonShadow!,
                    ]
                  : [],
              gradient: gradiantColors == null
                  ? null
                  : LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.center,
                      colors: gradiantColors!,
                    ),
            ),
            child: verifyIcon
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize:
                        isExpanded ? MainAxisSize.max : MainAxisSize.min,
                    children: [
                      !iconBeforeText
                          ? Row(
                              children: [
                                Text(
                                  title,
                                  style: isBold
                                      ? TextStyles.bold(
                                          color: (onPressed == null)
                                              ? AppColors.neutralColors5
                                              : textColor ??
                                                  AppColors.textForthColor,
                                          fontSize:
                                              fontSize ?? Dimensions.xLarge)
                                      : TextStyles.medium(
                                          color: (onPressed == null)
                                              ? AppColors.neutralColors5
                                              : textColor ??
                                                  AppColors.textForthColor,
                                          fontSize:
                                              fontSize ?? Dimensions.xLarge),
                                ),
                                const SizedBox(
                                  width: PaddingDimensions.large,
                                ),
                                shouldShowIcon
                                    ? Icon(
                                        buttonIcon,
                                        color: textColor,
                                        size: iconSize ?? IconDimensions.small,
                                      )
                                    : Icon(
                                        buttonIcon,
                                        color: Colors.white,
                                        size: iconSize ?? IconDimensions.small,
                                      ),
                              ],
                            )
                          : Row(
                              children: [
                                shouldShowIcon
                                    ? Icon(
                                        buttonIcon,
                                        color: textColor,
                                        size: iconSize ?? IconDimensions.small,
                                      )
                                    : Icon(
                                        buttonIcon,
                                        color: Colors.white,
                                        size: iconSize ?? IconDimensions.small,
                                      ),
                                const SizedBox(
                                  width: PaddingDimensions.large,
                                ),
                                Text(
                                  title,
                                  style: isBold
                                      ? TextStyles.bold(
                                          color: (onPressed == null)
                                              ? AppColors.neutralColors5
                                              : textColor ??
                                                  AppColors.textForthColor,
                                          fontSize:
                                              fontSize ?? Dimensions.xLarge)
                                      : TextStyles.medium(
                                          color: (onPressed == null)
                                              ? AppColors.neutralColors5
                                              : textColor ??
                                                  AppColors.textForthColor,
                                          fontSize:
                                              fontSize ?? Dimensions.xLarge,
                                        ),
                                ),
                              ],
                            ),
                    ],
                  )
                : !verifyIcon && prefixIcon == null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize:
                            isExpanded ? MainAxisSize.max : MainAxisSize.min,
                        children: [
                          shouldShowIcon
                              ? const SizedBox(
                                  width: PaddingDimensions.normal,
                                )
                              : isLoading
                                  ? const SizedBox(
                                      width: PaddingDimensions.normal,
                                    )
                                  : const SizedBox(),
                          isLoading
                              ? SizedBox(
                                  width: iconSize ?? IconDimensions.small,
                                )
                              : const SizedBox.shrink(),
                          Flexible(
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                              style: isBold == false && textStyle != null
                                  ? textStyle
                                  : isBold
                                      ? TextStyles.bold(
                                          color: (onPressed == null)
                                              ? AppColors.neutralColors5
                                              : textColor ??
                                                  AppColors.textPrimaryColor,
                                          fontSize: fontSize ?? Dimensions.xLarge,
                                        )
                                      : TextStyles.medium(
                                          color: (onPressed == null)
                                              ? AppColors.neutralColors5
                                              : textColor ??
                                                  AppColors.neutralColors1,
                                          fontSize:
                                              fontSize ?? Dimensions.xLarge),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          shouldShowIcon
                              ? const SizedBox(
                                  width: PaddingDimensions.normal,
                                )
                              : isLoading
                                  ? const SizedBox(
                                      width: PaddingDimensions.normal,
                                    )
                                  : const SizedBox(),
                          shouldShowIcon
                              ? Icon(
                                  buttonIcon,
                                  color: textColor,
                                  size: iconSize ?? IconDimensions.small,
                                )
                              : isLoading
                                  ? Icon(
                                      buttonIcon,
                                      color: AppColors.primary_500,
                                      size: iconSize ?? IconDimensions.small,
                                    )
                                  : const SizedBox(),
                          suffixIcon != null
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    left: PaddingDimensions.small,
                                  ),
                                  child: suffixIcon!,
                                )
                              : const SizedBox(
                                  width: 0,
                                ),
                        ],
                      )
                    : Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize:
                            isExpanded ? MainAxisSize.max : MainAxisSize.min,
                        children: [
                          prefixIcon != null
                              ? Padding(
                            padding: const EdgeInsets.only(
                              left: PaddingDimensions.small,
                              right: PaddingDimensions.small,
                            ),
                            child: prefixIcon!,
                          )
                              : const SizedBox(
                            width: 0,
                          ),
                          Flexible(
                            child: Text(
                              title,
                              style: isBold
                                  ? TextStyles.bold(
                                      color: (onPressed == null)
                                          ? AppColors.neutralColors5
                                          : textColor ??
                                              AppColors.textForthColor,
                                      fontSize: fontSize ?? Dimensions.xLarge)
                                  : TextStyles.medium(
                                      color: (onPressed == null)
                                          ? AppColors.neutralColors5
                                          : textColor ??
                                              AppColors.textForthColor,
                                      fontSize: fontSize ?? Dimensions.xLarge),

                            ),
                          ),
                          const SizedBox(
                            width: PaddingDimensions.large,
                          ),
                        ],
                      ),
          ),
        ),
        SwitchedWidget(
          isEnabled: isLoading,
          on: (context) => Positioned(
            right: 12,
            bottom: 8,
            top: 8,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: SizedBox(
                  height: IconDimensions.xSmall,
                  width: IconDimensions.xSmall,
                  child: CircularProgressIndicator(
                    color: textColor ?? AppColors.textForthColor,
                    strokeWidth: 2,
                  ),
                ),
              ),
            ),
          ),
          off: (context) => const SizedBox(),
        ),
      ],
    );
  }

  static AppButton primaryButton({
    required String title,
    VoidCallback? onPressed,
    bool isLoading = false,
    Key? key,
    double horizontalPadding = PaddingDimensions.x6Large,
    double verticalPadding = 0,
    double? buttonHeight,
    bool iconBeforeText = false,
    Color? color,
    IconData? buttonIcon,
    final List<Color>? gradiantColors,
    Color? textColor = AppColors.neutralColors1,
    double? fontSize = Dimensions.xxLarge,
    double cornerRadius = 100,
    bool isBold = false,
    Color? borderColor,
    bool? verifyIcon,
    bool? isShadow,
    bool? isExpanded,
    TextStyle? textStyle,
    double? borderWidth,
    Widget? prefixIcon,
    Color? backgroundColor = AppColors.primaryColorsSolid4Default,
    Widget? suffixIcon,
    double? iconSize,
    bool? isGradientDefault,
  }) {
    return AppButton(
      isShadow: isShadow ?? false,
      borderColor: borderColor,
      gradiantColors: gradiantColors,
      key: key,
      // ?? AppColors.buttonDefaultGradiantColors,
      fontSize: fontSize,
      title: title,
      onPressed: isLoading ? null : onPressed,
      iconBeforeText: iconBeforeText,
      cornerRadius: cornerRadius,
      isBold: isBold,
      textColor: textColor ?? AppColors.textForthColor,
      isLoading: isLoading,
      horizontalPadding: horizontalPadding,
      verticalPadding: verticalPadding,
      buttonHeight: buttonHeight ?? Dimensions.buttonHeight,
      buttonIcon: buttonIcon,
      verifyIcon: verifyIcon ?? false,
      color: color,
      isExpanded: isExpanded ?? false,
      textStyle: textStyle,
      borderWidth: borderWidth ?? 0,
      backgroundColor: backgroundColor,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      iconSize: iconSize,
      isGradientDefault: isGradientDefault,
    );
  }

  static AppButton languageButton({
    required String title,
    VoidCallback? onPressed,
    bool isLoading = false,
    double horizontalPadding = 48,
    double verticalPadding = 0,
    double? buttonHeight,
    Color? color,
    IconData? buttonIcon,
    final List<Color>? gradiantColors,
    Color? textColor,
    double? fontSize,
    double cornerRadius = 8,
    bool isBold = false,
    Color? borderColor = AppColors.primaryColor,
    bool? verifyIcon,
    bool? isShadow,
    bool? isExpanded,
    TextStyle? textStyle,
    double? borderWidth,
    Color? backgroundColor,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return AppButton(

      isShadow: isShadow ?? false,
      borderColor: borderColor,
      gradiantColors: gradiantColors ?? AppColors.buttonDefaultGradiantColors,
      fontSize: fontSize,
      title: title,
      onPressed: isLoading ? null : onPressed,
      cornerRadius: cornerRadius,
      isBold: isBold,
      textColor: textColor ?? AppColors.textForthColor,
      isLoading: isLoading,
      horizontalPadding: horizontalPadding,
      verticalPadding: verticalPadding,
      buttonHeight: buttonHeight ?? Dimensions.buttonHeight,
      buttonIcon: buttonIcon,
      verifyIcon: verifyIcon ?? false,
      color: color,
      isExpanded: isExpanded ?? false,
      textStyle: textStyle,
      borderWidth: borderWidth ?? 0,
      backgroundColor: backgroundColor,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }

  static AppButton defaultButton({
    required String title,
    VoidCallback? onPressed,
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
    Widget? prefixIcon,
    Widget? suffixIcon,
    BoxShadow? buttonShadow,
    Color? backgroundColor,
  }) {
    return AppButton(
      borderWidth: borderWidth ?? 0,
      isShadow: isShadow,
      borderColor: borderColor ?? AppColors.borderColor,
      gradiantColors: gradiantColors,
      fontSize: fontSize,
      title: title,
      onPressed: isLoading ? null : onPressed,
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
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      backgroundColor: backgroundColor,
      buttonShadow: buttonShadow,
    );
  }

  static AppButton questionButton({
    required String title,
    VoidCallback? onPressed,
    double horizontalPadding = 48,
    double verticalPadding = 0,
    double? buttonHeight,
    Color? color,
    Color? borderColor,
    Color? textColor,
    double? fontSize,
    double? cornerRadius,
    bool isBold = false,
    bool isLoading = false,
  }) {
    return AppButton(
      borderColor: borderColor ?? AppColors.borderColor,
      fontSize: fontSize,
      title: title,
      onPressed: isLoading ? null : onPressed,
      isLoading: isLoading,
      cornerRadius: cornerRadius ?? 24,
      isBold: isBold,
      textColor: textColor ?? AppColors.textForthColor,
      horizontalPadding: horizontalPadding,
      verticalPadding: verticalPadding,
      buttonHeight: buttonHeight ?? Dimensions.buttonHeight,
      color: color,
    );
  }

  static AppButton outlinedButton({
    required String title,
    VoidCallback? onPressed,
    Key? key,
    bool isLoading = false,
    bool isShadow = false,
    double horizontalPadding = 48,
    double verticalPadding = 0,
    double? buttonHeight,
    Color? color,
    Color? borderColor,
    double cornerRadius = 100,
    Color? textColor = AppColors.primaryColorsSolid4Default,
    double? fontSize = Dimensions.xxLarge,
    IconData? buttonIcon,
    final List<Color>? gradiantColors,
    bool? verifyIcon,
    bool? isExpanded,
    bool? isBold,
    bool? iconBeforeText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color? backgroundColor

  }) {
    return AppButton(
      isShadow: false,
      key: key,
      borderColor: borderColor ?? AppColors.primaryColorsSolid4Default,
      gradiantColors: gradiantColors ?? AppColors.buttonDefaultGradiantColors,
      fontSize: fontSize,
      borderWidth: 1,
      title: title,
      onPressed: isLoading ? null : onPressed,
      cornerRadius: cornerRadius,
      isBold: isBold ?? false,
      textColor: textColor ?? AppColors.primaryColorsSolid4Default,
      isLoading: isLoading,
      horizontalPadding: horizontalPadding,
      verticalPadding: verticalPadding,
      buttonHeight: buttonHeight ?? Dimensions.buttonHeight,
      buttonIcon: buttonIcon,
      verifyIcon: verifyIcon ?? false,
      isExpanded: isExpanded ?? false,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      iconBeforeText: iconBeforeText??false,
      backgroundColor: backgroundColor,
    );
  }

  static AppButton secondaryButton({
    required String title,
    VoidCallback? onPressed,
    bool isLoading = false,
    double horizontalPadding = 16,
    double verticalPadding = 0,
    double? buttonHeight,
    double? buttonWidth,
    IconData? buttonIcon,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return AppButton(
      title: title,
      onPressed: isLoading ? null : onPressed,
      isLoading: isLoading,
      backgroundColor: backgroundColor ?? AppColors.primaryColorsSolid4Default,
      borderColor: Colors.transparent,
      cornerRadius: 4,
      isBold: false,
      textColor: textColor ?? AppColors.textForthColor,
      horizontalPadding: horizontalPadding,
      verticalPadding: verticalPadding,
      buttonHeight: buttonHeight ?? Dimensions.buttonHeight,
      buttonIcon: buttonIcon,
    );
  }
}
