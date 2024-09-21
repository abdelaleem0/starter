import 'package:starter/common/custom_divider.dart';
import 'package:flutter/material.dart';

class CustomDividerWithPaddingNormal extends StatelessWidget {
  const CustomDividerWithPaddingNormal({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomDivider(
        horizontalPadding:0, verticalPadding: 8, dividerThickness: 1.2);
  }
}
