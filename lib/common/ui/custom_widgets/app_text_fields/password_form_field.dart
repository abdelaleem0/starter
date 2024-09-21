import 'package:flutter/material.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/services.dart';

class PasswordFormField extends StatelessWidget {
  final bool isDark;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onchange;
  final String? hintText;
  final Widget? suffix;
  final bool obscureText;
  final double? contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  const PasswordFormField({
    super.key,
    this.controller,
    this.validator,
    this.isDark = true,
    this.hintText,
    this.suffix,
    this.obscureText = false,
    this.onchange,
    this.contentPadding,
    this.inputFormatters
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.15),
            blurRadius: 15.0,
            offset: const Offset(5, 18),
            // offset: Offset(0.0, 0.75)
          )
        ],
      ),
      child: TextFormField(
        // obscuringCharacter: ,
        cursorColor: AppColors.primaryColor,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        textDirection: TextDirection.ltr,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyles.regular(
            color: AppColors.neutral_100,
            fontSize: Dimensions.large,
          ),
          filled: true,
          fillColor: AppColors.textFieldBackgroundPrimaryColor,
          suffixIcon: suffix,
          // suffixIconConstraints: BoxConstraints(
          //   maxWidth: 4,
          // ),
          contentPadding: contentPadding == null ? const EdgeInsets.symmetric(
              vertical: PaddingDimensions.normal - 5,
              horizontal: PaddingDimensions.normal) : EdgeInsets.symmetric(
              vertical: contentPadding??0, horizontal: contentPadding??0),
          errorStyle: const TextStyle(color: AppColors.secondary_500),
          errorBorder: const OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
                color: AppColors.secondary_500,
                width: 1.7,
                style: BorderStyle.solid),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
                color: AppColors.secondary_500,
                width: 1.7,
                style: BorderStyle.solid),
          ),
          border: const OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(PaddingDimensions.xxLarge)),
            borderSide: BorderSide(
                color: AppColors.borderColor,
                width: 1,
                style: BorderStyle.solid),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
                color: AppColors.borderColor,
                width: 1,
                style: BorderStyle.solid),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              color: AppColors.borderColor,
              width: 1.7,
              style: BorderStyle.solid,
            ),
          ),
          counterText: "",
        ),
        obscureText: obscureText,
        style: TextStyles.regular(
            color: obscureText ? AppColors.neutral_100 : AppColors.textPrimaryColor, fontSize: Dimensions.normal),
        obscuringCharacter: "*",
        validator: validator,
        onChanged: onchange,
        inputFormatters: inputFormatters
      ),
    );
  }
}
