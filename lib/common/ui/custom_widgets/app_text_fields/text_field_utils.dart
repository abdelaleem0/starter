import 'package:flutter/material.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';

InputDecoration authenticationPhoneInputDecoration({
  String? hintText,
  Color? focusBorderColor,
}) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyles.regular(
          color: AppColors.neutral_100, fontSize: Dimensions.normal),
      labelStyle: TextStyles.regular(
        color: AppColors.greyColor,
      ),
      focusColor: focusBorderColor,
      fillColor: AppColors.textPrimaryColor,
      errorStyle: const TextStyle(color: AppColors.errorLight),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
        // borderRadius:
        //     BorderRadius.all(Radius.circular(PaddingDimensions.xLarge)),
        borderSide: BorderSide(
            color: AppColors.secondaryColorsSolidOrange4Default, width: 1, style: BorderStyle.solid),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: PaddingDimensions.normal,
        horizontal: PaddingDimensions.xxLarge,
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(2), bottomLeft: Radius.circular(2)),
        borderSide: BorderSide(
            color: AppColors.borderColor, width: 0.3, style: BorderStyle.solid),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(2), bottomLeft: Radius.circular(2)),
        borderSide: BorderSide(
            color: AppColors.borderColor, width: 1, style: BorderStyle.solid),
      ),
      focusedBorder:  OutlineInputBorder(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2), bottomLeft: Radius.circular(2)),
        borderSide: BorderSide(
            color: focusBorderColor??AppColors.borderColor, width: 1, style: BorderStyle.solid),
      ),
      focusedErrorBorder: InputBorder.none,
      counterText: "");
}

InputDecoration authenticationInputDecoration(
    {bool isDark = true,
    Widget? suffixIcon,
    Widget? prefixIcon,
    String? hintText,
    double? borderRaduis,
    Color? borderColor,
    Color? errorBorderColor,
    Color? focusBorderColor,
      InputBorder?border,
      String? errorText,
    String? labelText,
      EdgeInsetsGeometry? contentPadding,
    double? errorTextFontSize,
    int? maxErrorLines,
      TextStyle? hintStyle,
      BoxConstraints? suffixIconConstraints,
      BoxConstraints? prefixIconConstraints,

    }) {
  return InputDecoration(
    labelText: labelText,
    suffixIcon: suffixIcon,
    prefixIcon: prefixIcon,
    hintText: hintText,
    errorText: errorText,
    hintStyle: hintStyle ??TextStyles.regular(
      color: AppColors.neutral_100,
      fontSize: Dimensions.large,
    ),
    filled: true,
    errorStyle: TextStyles.regular(
      color: AppColors.secondary_500,
      fontSize: errorTextFontSize??Dimensions.large,
    ),
    errorMaxLines:maxErrorLines,
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(borderRaduis ?? 16)),
      borderSide:  BorderSide(
          color: errorBorderColor ?? AppColors.borderColor, width: .6, style: BorderStyle.solid),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(borderRaduis ?? 16)),
      borderSide:  BorderSide(
          color: errorBorderColor ?? AppColors.neutralColors3, width: .6, style: BorderStyle.solid),
    ),
    fillColor: AppColors.textForthColor,
    suffixIconConstraints: suffixIconConstraints,
    prefixIconConstraints: prefixIconConstraints,
    contentPadding: contentPadding ?? const EdgeInsets.symmetric(
            vertical: PaddingDimensions.xxLarge - 5,
            horizontal: PaddingDimensions.xxLarge),
    border:border ?? OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(borderRaduis ?? 16)),
      borderSide: BorderSide(
          color: borderColor ?? AppColors.borderColor,
          width: 1,
          style: BorderStyle.none),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(borderRaduis ?? 16)),
      borderSide: BorderSide(
          color: borderColor ?? AppColors.borderColor,
          width: 1,
          style: BorderStyle.solid),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(borderRaduis ?? 16)),
      borderSide: BorderSide(
          color: focusBorderColor ?? AppColors.primaryColorsSolid4Default,
          width: 1,
          style: BorderStyle.solid),
    ),
    counterText: "",
  );
}

InputDecoration oneSideInputDecoration(
    {bool isDark = true,
      Widget? suffixIcon,
      Widget? prefixIcon,
      String? hintText,
      double? borderRaduis,
      Color? borderColor,
      Color? focusBorderColor,
      String? errorText,
      String? labelText,
      EdgeInsetsGeometry? contentPadding,
      double? errorTextFontSize,
      int? maxErrorLines,
      TextStyle? hintStyle,
       BoxConstraints? suffixIconConstraints,
       BoxConstraints? prefixIconConstraints,

    }) {
  return InputDecoration(

    labelText: labelText,
    suffixIcon: suffixIcon,
    prefixIcon: prefixIcon,
    hintText: hintText,
    isDense: true,
    errorText: errorText,

    hintStyle: hintStyle??TextStyles.regular(
      color: AppColors.neutral_300,
      fontSize: Dimensions.large,

    ),
    // filled: true,
    errorStyle: TextStyles.regular(
      color: AppColors.secondary_500,
      fontSize: errorTextFontSize??Dimensions.large,
    ),
    suffixIconConstraints: suffixIconConstraints,
    prefixIconConstraints: prefixIconConstraints,


    errorMaxLines:maxErrorLines,
    errorBorder: UnderlineInputBorder(
      borderSide:  BorderSide(
          color: borderColor ?? AppColors.neutral_100, width: .6, style: BorderStyle.solid),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide:  BorderSide(
          color: borderColor ?? AppColors.neutral_100, width: .6, style: BorderStyle.solid),
    ),
    contentPadding: contentPadding ?? const EdgeInsets.only(top: 10, bottom: 8),
    border: UnderlineInputBorder(
      borderSide: BorderSide(
          color: borderColor ?? AppColors.neutral_100,
          width: 1,
          style: BorderStyle.none),
    ),
      // suffixIconConstraints: const BoxConstraints(
      //   minWidth: 2,
      //   minHeight: 2,
      // ),

    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
          color: borderColor ?? AppColors.neutral_100,
          width: 1,
          style: BorderStyle.solid),
    ),

    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
          color: focusBorderColor ?? AppColors.secondaryColorsSolidOrange4Default,
          width: 1,
          style: BorderStyle.solid),
    ),
    counterText: "",
  );

}
InputDecoration noneInputDecoration(
    {bool isDark = true,
      Widget? suffixIcon,
      Widget? prefixIcon,
      String? hintText,
      double? borderRaduis,
      Color? borderColor,
      Color? focusColor,
      String? errorText,
      String? labelText,
      EdgeInsetsGeometry? contentPadding,
      double? errorTextFontSize,
      int? maxErrorLines,
      TextStyle? hintStyle,
      BoxConstraints? suffixIconConstraints,
      BoxConstraints? prefixIconConstraints,

    }) {
  return InputDecoration(
    labelText: labelText,
    suffixIcon: suffixIcon,
    prefixIcon: prefixIcon,
    hintText: hintText,

    isDense: true,
    errorText: errorText,
    focusColor: focusColor,
    hintStyle: hintStyle??TextStyles.regular(
      color: AppColors.neutral_300,
      fontSize: Dimensions.large,

    ),
    // filled: true,
    errorStyle: TextStyles.regular(
      color: AppColors.secondary_500,
      fontSize: errorTextFontSize??Dimensions.large,
    ),
    errorMaxLines:maxErrorLines,
    errorBorder: UnderlineInputBorder(
      borderSide:  BorderSide(
          color: borderColor ?? AppColors.neutral_100, width: .6, style: BorderStyle.solid),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide:  BorderSide(
          color: borderColor ?? AppColors.neutral_100, width: .6, style: BorderStyle.solid),
    ),
    contentPadding: contentPadding ?? const EdgeInsets.only(top: 10, bottom: 8),
    border: UnderlineInputBorder(
      borderSide: BorderSide(
          color: borderColor ?? AppColors.neutral_100,
          width: 1,
          style: BorderStyle.none),
    ),
    suffixIconConstraints: suffixIconConstraints,
    prefixIconConstraints: prefixIconConstraints,

    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    counterText: "",
  );

}