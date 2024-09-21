import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';

class NormalText extends StatelessWidget {
  final String text;
  final Color? color;
  final bool? noPadding;
  final bool? isPoritire;

  const NormalText({super.key, required this.text, this.color,  this.noPadding, this.isPoritire});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: noPadding==true?0:isPoritire==true? PaddingDimensions.small: PaddingDimensions.normal
          // top: PaddingDimensions.large,
          ),
      child: Text(text,

          style: TextStyles.regular(
              color: color??AppColors.neutralColors7,
              fontSize: Dimensions.xLarge,
              height: 1.4),
          textAlign: TextAlign.start),
    );
  }
}
