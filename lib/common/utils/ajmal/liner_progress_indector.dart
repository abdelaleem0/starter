import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';

class LinerProgressIndicatorWidget extends StatelessWidget {
  final double value;
  const LinerProgressIndicatorWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PaddingDimensions.large,),
      child: LinearProgressIndicator(
        value: value,
        color: AppColors.neutralColors1,
        backgroundColor: AppColors.neutralColors1.withOpacity(.3),
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
        minHeight: PaddingDimensions.normal,
      ),
    );
  }
}
