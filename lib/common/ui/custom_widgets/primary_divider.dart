import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';

class PrimaryDivider extends StatelessWidget {
  const PrimaryDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
          vertical: PaddingDimensions.large,
          horizontal: PaddingDimensions.x5Large),
      child: Divider(thickness: 1),
    );
  }
}
