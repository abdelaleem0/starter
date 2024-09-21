import 'package:starter/app/authentication/utils/localization/authentication_localizer.dart';
import 'package:starter/common/ui/custom_widgets/app_text_fields/app_text_field_tile.dart';
import 'package:starter/common/ui/custom_widgets/app_text_fields/app_text_form_field.dart';
import 'package:starter/common/ui/custom_widgets/app_text_fields/format/input_formatters_TextFormField.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/validation_rules.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PasswordWidget extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(String text)? onChange;
  final bool showPasswordValidator;
  final String? labelName;
  final String? hintText;
  final String? Function(String?)? validator;

  const PasswordWidget({
    super.key,
    this.controller,
    this.onChange,
    this.labelName,
    this.hintText,
    this.showPasswordValidator = false,
    this.validator,
  });

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  bool _passwordObscured = true;

  void onEyePressed() {
    setState(() {
      _passwordObscured = !_passwordObscured;
    });
  }

  String? _passwordValidator(String? password) =>
      Validation(password).passwordValidation(password);

  @override
  Widget build(BuildContext context) {
    return AppTextFieldTile(
      errorBorderColor: AppColors.semanticColorsError4Default,
      textFieldType: TextFieldType.normal,
      borderColor: AppColors.neutralColors3,
      fontSize: Dimensions.xLarge,
      inputFormatters: [
        NoStartWithSpaceFormatter(),
      ],
      label: widget.labelName ?? AuthenticationLocalizer.password,
      controller: widget.controller,
      obscureText: _passwordObscured,
      hintText: widget.hintText ?? AuthenticationLocalizer.password,
      onchange: widget.onChange,
      suffix: GestureDetector(
        onTap: onEyePressed,
        behavior: HitTestBehavior.translucent,
        child: Icon(
          _passwordObscured ? Iconsax.eye_slash : Iconsax.eye,
          color: AppColors.neutralColors7,
          size: _passwordObscured ? 24 : 24,
        ),
      ),
      maxErrorLines: 2,
      validator: widget.validator ??
          (value) {
            return _passwordValidator(value);
          },
      textDirection: TextDirection.ltr,
    );
  }
}
