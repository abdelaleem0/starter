import 'package:starter/app/authentication/utils/localization/authentication_localizer.dart';
import 'package:starter/common/ui/custom_widgets/app_text_fields/app_text_field_tile.dart';
import 'package:starter/common/ui/custom_widgets/app_text_fields/app_text_form_field.dart';
import 'package:starter/common/ui/custom_widgets/app_text_fields/format/input_formatters_TextFormField.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/validation_rules.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailWidget extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(String text)? onChange;
  const EmailWidget({super.key, this.controller, this.onChange});

  @override
  State<EmailWidget> createState() => _EmailWidgetState();
}

class _EmailWidgetState extends State<EmailWidget> {
  String? _emailValidator(String? email) => Validation(email).emailValidation();

  @override
  Widget build(BuildContext context) {
    return AppTextFieldTile(
        errorBorderColor: AppColors.semanticColorsError4Default,
        textFieldType: TextFieldType.normal,
        borderColor: AppColors.neutralColors3,
        fontSize: Dimensions.xLarge,
        label: AuthenticationLocalizer.email,
        hintText: AuthenticationLocalizer.emailAddressHint,
        maxErrorLines: 2,
        onchange: widget.onChange,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s")),
          NoStartWithSpaceFormatter(),
        ],
        textDirection: TextDirection.ltr,
        controller: widget.controller,
        validator: (value) {
          return _emailValidator(value);
        }

    );
  }
}