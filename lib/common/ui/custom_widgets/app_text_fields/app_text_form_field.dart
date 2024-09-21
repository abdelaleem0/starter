import 'package:starter/common/keyboardoverlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'text_field_utils.dart';

class AppTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final bool obscureText;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  final bool isDark;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final String? hint;
  final int? maxErrorLines;
  final String? labelText;
  final Widget? suffix;
  final Widget? prefix;
  final Color? borderColor;
  final Color? isShadowColor;
  final double? borderRaduis;
  final void Function(String)? onchange;
  final VoidCallback? onTap;
  final bool? isEnabled;
  final List<TextInputFormatter>? inputFormatters;
  final bool isValid;
  final TextDirection? textDirection;
  final Color? textColor;
  final Color? focusBorderColor;
  final EdgeInsetsGeometry? contentPadding;
  final FocusNode? focusNode;
  final bool? itIncludeTextDone;
  final AutovalidateMode? autoValidateMode;
  final double? errorTextFontSize;
  final TextFieldType textFieldType;
  final TextStyle? hintStyle;
  final double? fontSize;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final Color? focusColor;
  final Color? errorBorderColor;
  final bool autoFocus;
  final InputBorder? border;
  final Color? cursorColor;

  final ScrollController? scrollController;
  const AppTextFormField(
      {super.key,
      this.controller,
      this.obscureText = false,
      this.validator,
      this.maxLength,
      this.isDark = true,
      this.maxLines = 1,
      this.minLines,
      this.keyboardType,
      this.hint,
      this.maxErrorLines,
      this.labelText,
      this.suffix,
      this.prefix,
      this.borderColor,
      this.focusColor,
      this.errorBorderColor,
      this.focusBorderColor,
      this.isShadowColor,
      this.isEnabled,
      this.borderRaduis,
      this.onchange,
      this.onTap,
      this.inputFormatters,
      this.isValid = true,
      this.initialValue,
      this.textDirection,
      this.textColor,
      this.contentPadding,
      this.focusNode,
      this.itIncludeTextDone,
      this.autoValidateMode,
      this.errorTextFontSize,
      this.textFieldType = TextFieldType.none,
      this.hintStyle,
      this.fontSize,
      this.suffixIconConstraints,
      this.border,
      this.prefixIconConstraints,
      this.scrollController,
      this.autoFocus = false,
      this.cursorColor
      });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: widget.autoValidateMode,
      focusNode: widget.focusNode,
      initialValue: widget.initialValue,
      cursorColor: widget.cursorColor ?? AppColors.primaryColor,
      scrollController: widget.scrollController,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      textDirection: widget.textDirection,
      enabled: widget.isEnabled,
      keyboardType: widget.keyboardType,
      autofocus: widget.autoFocus,
      inputFormatters: widget.inputFormatters,
      controller: widget.controller,
      decoration: widget.textFieldType == TextFieldType.oneSide
          ? oneSideInputDecoration(
              errorTextFontSize: widget.errorTextFontSize ?? Dimensions.large,
              labelText: widget.labelText,
              borderRaduis: widget.borderRaduis,
              borderColor: widget.borderColor,
              focusBorderColor: widget.focusBorderColor,
              contentPadding: widget.contentPadding?? const EdgeInsets.symmetric(
                  horizontal: PaddingDimensions.medium,
                  vertical: PaddingDimensions.normal
              ),
              prefixIcon: widget.prefix,
              suffixIcon: widget.suffix,
              hintText: widget.hint,
              maxErrorLines: widget.maxErrorLines,
              hintStyle: widget.hintStyle,
              suffixIconConstraints: widget.suffixIconConstraints,
              prefixIconConstraints: widget.prefixIconConstraints,
            )
          : widget.textFieldType == TextFieldType.normal
              ? authenticationInputDecoration(
        errorBorderColor:widget.errorBorderColor,
                  border: widget.border,
                  errorTextFontSize:
                      widget.errorTextFontSize ?? Dimensions.large,
                  focusBorderColor: widget.focusBorderColor,
                  labelText: widget.labelText,
                  borderRaduis: widget.borderRaduis,
                  borderColor:AppColors.defaultBorderField,
                  suffixIcon: widget.suffix,
                  hintText: widget.hint,
                  contentPadding: widget.contentPadding?? const EdgeInsets.symmetric(
                      horizontal: PaddingDimensions.medium,
                      vertical: PaddingDimensions.normal

                  ),
                  maxErrorLines: widget.maxErrorLines,
                  suffixIconConstraints: widget.suffixIconConstraints,
                  hintStyle: widget.hintStyle,
                )
              : noneInputDecoration(
                  suffixIconConstraints: widget.suffixIconConstraints,
                  errorTextFontSize:
                      widget.errorTextFontSize ?? Dimensions.large,
                  labelText: widget.labelText,
                  borderRaduis: widget.borderRaduis,
                  focusColor: widget.focusColor,
                  borderColor: widget.borderColor,
                  suffixIcon: widget.suffix,
                  hintText: widget.hint,
                  contentPadding: widget.contentPadding,
                  maxErrorLines: widget.maxErrorLines,
                  hintStyle: widget.hintStyle,
                ),
      obscureText: widget.obscureText,
      style: TextStyles.regular(
        color: widget.isValid
            ? widget.textColor ?? AppColors.neutralColors7
            : AppColors.errorLight,
        fontSize: widget.fontSize ?? Dimensions.xLarge,
      ),
      validator: widget.validator,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      onChanged: widget.onchange,
      onTap: () {
        if (widget.itIncludeTextDone == null ||
            widget.itIncludeTextDone == false) {
        } else {
          widget.focusNode?.addListener(() {
            bool hasFocus = widget.focusNode!.hasFocus;
            if (hasFocus) {
              KeyboardOverlay.showOverlay(context);
            } else {
              KeyboardOverlay.removeOverlay();
            }
          });
        }
        widget.onTap;
      },
    );
  }
}

enum TextFieldType { normal, none, oneSide }

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: capitalize(newValue.text),
      selection: newValue.selection,
    );
  }
}

String capitalize(String value) {
  if (value.trim().isEmpty) return "";
  return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
}
