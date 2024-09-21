import 'package:starter/common/ui/custom_widgets/app_text_fields/app_text_form_field.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFieldTile extends StatelessWidget {
  const AppTextFieldTile({
    super.key,
    required this.label,
    this.hintText,
    this.onchange,
    this.validator,
    this.obscureText = false,
    this.inputFormatters,
    this.suffix,
    this.prefix,
    this.textInputType,
    this.isOptionalTitle = false,
    this.maxLength,
    this.controller,
    this.errorTextFontSize,
    this.textDirection,
    this.maxErrorLines = 2,
    this.isEnabled,
    this.onTap,
    this.textFieldType = TextFieldType.oneSide,
    this.maxLines,
    this.borderColor,
    this.errorBorderColor,
    this.hintStyle,
    this.autoValidateMode,
    this.suffixIconConstraints,
    this.prefixIconConstraints,
    this.fontSize,
    this.contentPadding,
    this.labelTextStyle,
  });

  final int? maxLines;
  final String label;
  final String? hintText;
  final bool obscureText;
  final void Function(String)? onchange;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  final Widget? prefix;
  final int? maxLength;
  final TextInputType? textInputType;
  final bool isOptionalTitle;
  final TextEditingController? controller;
  final double? errorTextFontSize;
  final double? fontSize;
  final TextDirection? textDirection;
  final int? maxErrorLines;
  final bool? isEnabled;
  final void Function()? onTap;
  final TextFieldType textFieldType;
  final Color? borderColor;
  final TextStyle? hintStyle;
  final AutovalidateMode? autoValidateMode;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? labelTextStyle;
  final Color? errorBorderColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isOptionalTitle
            ? _OptionalRichText(
                title: label,
              )
            : Text(
                label,
                style: labelTextStyle ??
                    TextStyles.medium(
                      color: AppColors.neutralColors7,
                      fontSize: Dimensions.xLarge,
                    ),
              ),
        const SizedBox(
          height: PaddingDimensions.small,
        ),
        AppTextFormField(
          errorBorderColor: errorBorderColor,
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(
                  vertical: PaddingDimensions.medium,
                  horizontal: PaddingDimensions.large),
          hintStyle: hintStyle,
          borderColor: borderColor ?? AppColors.backgroundGrey,
          maxLines: maxLines ?? 1,
          onTap: onTap,
          isEnabled: isEnabled,
          controller: controller,
          keyboardType: textInputType,
          inputFormatters: inputFormatters,
          hint: hintText,
          onchange: onchange,
          validator: validator,
          obscureText: obscureText,
          suffix: suffix,
          borderRaduis: 12,
          textFieldType: textFieldType,
          maxLength: maxLength,
          maxErrorLines: maxErrorLines,
          errorTextFontSize: errorTextFontSize,
          textColor: AppColors.neutralColors7,
          textDirection: textDirection,
          prefix: prefix,
          autoValidateMode: autoValidateMode,
          suffixIconConstraints: suffixIconConstraints,
          prefixIconConstraints: prefixIconConstraints,
          fontSize: fontSize,
        ),
      ],
    );
  }
}

class _OptionalRichText extends StatelessWidget {
  final String title;

  const _OptionalRichText({required this.title});

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.start,
        text: TextSpan(children: [
          TextSpan(
              text: title,
              style: TextStyles.medium(
                color: AppColors.neutral_800,
                fontSize: Dimensions.xLarge,
              )),
          // TextSpan(
          //   text: ' (${UserProfileLocalizer.optional})',
          //   style:
          //       TextStyles.regular(color: AppColors.neutral_200, fontSize: 14),
          // ),
        ]));
  }
}
