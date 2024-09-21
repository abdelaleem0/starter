import 'package:starter/common/ui/custom_widgets/app_progress/app_progress_indicator.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';

class AppMaterialButtons extends StatelessWidget {
  const AppMaterialButtons(
      {super.key,
      this.onPressed,
      this.buttonColor,
      this.elevation,
      this.padding,
      this.height,
      this.shape,
      this.child,
      this.text,
      this.disabledButtonColor,
      this.minWidth,
      this.textStyle,
      this.isLoading = false,
      this.isExpanded,
      this.textColor,
      this.fontSize,
      this.disabledTextColor,
      this.rightWidget,
      this.leftWidget,
      this.borderRadius,
      this.margin, this.borderColor});
  final void Function()? onPressed;
  final Color? buttonColor;
  final String? text;
  final Color? textColor;
  final Color? disabledTextColor;
  final double? fontSize;
  final TextStyle? textStyle;
  final Color? disabledButtonColor;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final ShapeBorder? shape;
  final Widget? child;
  final double? minWidth;
  final bool isLoading;
  final bool? isExpanded;
  final Widget? rightWidget;
  final Widget? leftWidget;
  final double? borderRadius;
  final Color? borderColor;

  static AppMaterialButtons primaryButton({
    ShapeBorder? shape,
    required String text,
    VoidCallback? onPressed,
    bool? isExpanded,
    Color? buttonColor,
    Color? textColor,
    TextStyle? textStyle,
    EdgeInsetsGeometry? margin,
    bool? isLoading,
    double? height,
    double? fontSize,
    TextDecoration? textDecoration,
    Widget? rightWidget,
    Widget? leftWidget,
    EdgeInsetsGeometry? padding,
    double? borderRadius,
    double? minWidth,
    Color? borderColor,
  }) {
    return AppMaterialButtons(
      padding: padding,
      shape: shape,
      margin: margin,
      text: text,
      textStyle: textStyle,
      fontSize: fontSize,
      height: height,
      textColor: textColor,
      buttonColor: buttonColor,
      isExpanded: isExpanded ?? true,
      onPressed: onPressed,
      isLoading: isLoading ?? false,
      rightWidget: rightWidget,
      leftWidget: leftWidget,
      borderRadius: borderRadius,
      minWidth: minWidth,
      borderColor: borderColor,
    );
  }

  static AppMaterialButtons textButton({
    required String text,
    double? fontSize,
    void Function()? onPressed,
    TextStyle? textStyle,
    TextDecoration? textDecoration,
    Color? disabledTextColor,
    Color? textColor,
    double? height,
    bool? isLoading,
  }) {
    return AppMaterialButtons(
      text: text,
      height: height,
      onPressed: onPressed,
      disabledTextColor: disabledTextColor ?? AppColors.primary_200,
      buttonColor: Colors.transparent,
      disabledButtonColor: Colors.transparent,
      elevation: 0,
      isExpanded: false,
      textColor: textColor ?? AppColors.primary_300,
      fontSize: fontSize,
      isLoading: isLoading ?? false,
    );
  }

  static AppMaterialButtons outline({
    required String text,
    double? fontSize,
    void Function()? onPressed,
    TextStyle? textStyle,
    TextDecoration? textDecoration,
    Color? disabledTextColor,
    Color? textColor,
    bool isExpanded = false,
    double? height,
    Color? borderColor,
  }) {
    return AppMaterialButtons(
      text: text,
      height: height,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
              width: 1, color: borderColor ?? AppColors.primary_300)),
      onPressed: onPressed,
      disabledTextColor: disabledTextColor ?? AppColors.primary_400,
      buttonColor: Colors.transparent,
      disabledButtonColor: Colors.transparent,
      elevation: 0,
      isExpanded: isExpanded,
      textColor: textColor ?? AppColors.primary_300,
      fontSize: fontSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: MaterialButton(
        onPressed: isLoading ? null : onPressed,
        focusColor: buttonColor ?? AppColors.primary_500,
        disabledColor: disabledButtonColor ?? AppColors.primary_200,
        splashColor: Colors.transparent,
        textColor: textColor ?? AppColors.forthColor,
        color: buttonColor ?? AppColors.primary_500,
        elevation: elevation ?? 0,
        highlightColor: Colors.transparent,
        focusElevation: 0,
        highlightElevation: 0,
        padding: padding,
        height: height,
        disabledTextColor: disabledTextColor ?? AppColors.forthColor,
        disabledElevation: elevation,
        minWidth: minWidth,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              side: BorderSide(
                width: 1, color: borderColor ?? Colors.transparent)
            ),
        child: Row(
          mainAxisSize:
              isExpanded ?? false ? MainAxisSize.max : MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isExpanded ?? false
                ? Expanded(
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    leftWidget != null ? leftWidget! : const SizedBox(),
                    Flexible(
                      child: FittedBox(
                        child: child ??
                            Text(
                              text ?? 'Enter text parameter',
                              style: textStyle ??
                                  TextStyles.regular(
                                      color: textColor ??
                                          AppColors.forthColor,
                                      fontSize: fontSize ??
                                          Dimensions.xxLarge),
                            ),
                      ),
                    ),
                    rightWidget != null
                        ? rightWidget!
                        : const SizedBox(),
                  ],
                ),
              ),
            )
                : Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  leftWidget != null ? leftWidget! : const SizedBox(),
                  FittedBox(
                    child: child ??
                        Text(
                          text ?? 'Enter text parameter',
                          style: textStyle ??
                              TextStyles.regular(
                                  color:
                                  textColor ?? AppColors.forthColor,
                                  fontSize:
                                  fontSize ?? Dimensions.large),
                        ),
                  ),
                  rightWidget != null ? rightWidget! : const SizedBox(),
                ],
              ),
            ),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              key: ValueKey(isLoading),
              child: isLoading
                  ? Container(
                margin: const EdgeInsetsDirectional.only(
                    start: PaddingDimensions.large),
                height: IconDimensions.xSmall,
                width: IconDimensions.xSmall,
                child: AppProgressIndicator(
                  color: textColor ?? AppColors.forthColor,
                  strokeWidth: 2,
                ),
              ) : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
