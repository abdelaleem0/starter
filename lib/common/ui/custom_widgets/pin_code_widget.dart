import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';

class PinCodeWidget extends StatelessWidget {
  final bool hasError;
  final void Function(String value) onChange;
  final String? Function(String?)? validator;
  final TextEditingController codeController;
  final int length;

  PinCodeWidget({
    super.key,
    required this.hasError,
    required this.onChange,
    this.validator,
    required this.codeController,
    this.length = 4,
  });

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp('[0-9]'))
        ],
        appContext: context,
        length: length,
        focusNode: _focusNode,
        enableActiveFill: false,
        keyboardType: TextInputType.phone,
        textStyle: TextStyles.medium(
          fontSize: Dimensions.xxxLarge,
          color: AppColors.neutral_900,
        ),
        hintCharacter: '',
        hintStyle: const TextStyle(height: 1, color: AppColors.neutral_200),
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            fieldHeight: 48,
            fieldWidth: 80,
            activeFillColor: hasError
                ? AppColors.danger_600.withOpacity(.1)
                : Colors.transparent,
            inactiveFillColor: Colors.transparent,
            selectedFillColor: Colors.transparent,
            activeColor: hasError
                ? AppColors.danger_600
                : AppColors.primaryColorsSolid4Default,
            disabledColor: Colors.black,
            inactiveColor: AppColors.defaultBorderField,
            selectedColor: AppColors.primaryColorsSolid4Default,
            // errorBorderColor: Colors.red,
            borderWidth: 1,
            borderRadius: BorderRadius.circular(12),
            fieldOuterPadding: const EdgeInsets.symmetric(
              vertical: PaddingDimensions.medium,
            )),
        animationType: AnimationType.fade,
        onChanged: onChange,
        showCursor: true,
        cursorColor: AppColors.primary_500,
        validator: validator,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        controller: codeController,
        autoDisposeControllers: false,
        cursorHeight: 17,
      ),
    );
  }
}
