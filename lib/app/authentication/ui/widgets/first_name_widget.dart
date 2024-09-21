import 'package:starter/app/authentication/utils/localization/authentication_localizer.dart';
import 'package:starter/common/ui/custom_widgets/app_text_fields/app_text_field_tile.dart';
import 'package:starter/common/ui/custom_widgets/app_text_fields/app_text_form_field.dart';
import 'package:starter/common/ui/custom_widgets/app_text_fields/format/input_formatters_TextFormField.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/validation_rules.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstNameWidget extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(String text)? onChange;
  const FirstNameWidget({super.key, this.controller, this.onChange});

  @override
  State<FirstNameWidget> createState() => _FirstNameWidgetState();
}

class _FirstNameWidgetState extends State<FirstNameWidget> {
  String? _firstNameValidator(String? firstName) =>
      Validation(firstName).firstNameValidation();
  @override
  Widget build(BuildContext context) {
    return AppTextFieldTile(
      contentPadding: const EdgeInsets.all(PaddingDimensions.large),
      onchange:widget.onChange,
      textFieldType: TextFieldType.normal,
      borderColor: AppColors.neutralColors3,
      fontSize: Dimensions.xLarge,
      label: AuthenticationLocalizer.enterYourFirstName,
      hintText: AuthenticationLocalizer.exName,
      maxErrorLines: 2,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s")),
        NoStartWithSpaceFormatter(),
        // NoStartWithSpaceFormatter(),
      ],
      textDirection: TextDirection.ltr,
      controller: widget.controller,

      maxLength: 50,
      validator: (text) {
        return _firstNameValidator(text);
      },
    );
  }
}
