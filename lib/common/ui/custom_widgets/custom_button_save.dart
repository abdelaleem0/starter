import 'package:flutter/material.dart';
import 'package:starter/common/ui/custom_widgets/app_buttons/app_buttons.dart';
import 'package:starter/common/utils/dimensions.dart';

class CustomButtonPressed extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CustomButtonPressed({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: PaddingDimensions.xxLarge,
            vertical: PaddingDimensions.large),
        child: AppButton.primaryButton(
          isExpanded: true,
          isShadow: false,
          title: title,
          isBold: true,
          onPressed: onTap,
        ),
      ),
    );
  }
}
