import 'package:starter/common/ui/custom_widgets/app_text_fields/text_field_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/common/blocs/app_language/app_language_bloc.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  final bool isDark;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final String? hint;
  final Widget? suffix;
  final Widget? prefix;
  final Color? borderColor;
  final void Function(String)? onchange;
  final String? errorText;

  const PhoneField({
    super.key,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.maxLength,
    this.isDark = true,
    this.maxLines = 1,
    this.minLines,
    this.keyboardType,
    this.hint,
    this.suffix,
    this.prefix,
    this.borderColor,
    this.onchange,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    var lang =
        BlocProvider.of<AppLanguageBloc>(context).state.locale.languageCode;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.15),
              blurRadius: 15.0,
              // offset: Offset(0.0, 0.75)
            )
          ],
        ),
        child: TextFormField(
          textAlign: lang == "en" ? TextAlign.end : TextAlign.start,
          textDirection: lang == "en" ? TextDirection.rtl : TextDirection.rtl,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp('[0-9]'))
          ],
          keyboardType: TextInputType.phone,
          controller: controller,
          decoration: authenticationInputDecoration(
            borderColor: borderColor ?? AppColors.borderColor,
            suffixIcon: suffix,
            prefixIcon: prefix,
            hintText: hint,
            errorText: errorText,
          ),
          obscureText: obscureText,
          style: TextStyles.regular(
            color: AppColors.textPrimaryColor,
            fontSize: Dimensions.large,
          ),
          validator: validator,
          maxLength: maxLength,
          maxLines: maxLines,
          minLines: minLines,
          onChanged: onchange,
        ),
      ),
    );
  }
}
