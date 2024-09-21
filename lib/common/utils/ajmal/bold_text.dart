import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  final String text;
  final double fontSize;
  final TextAlign? textAlign;
  final Color? color;
  final TextOverflow? overflow;

  const BoldText({
    super.key,
    required this.text,
    required this.fontSize,
    this.textAlign,
    this.color,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text.trim(),
        overflow: overflow,
        style: TextStyles.semiBold(
            color: color ?? AppColors.neutralColors7,
            fontSize: fontSize,
            ),
        maxLines: 2,
        textAlign: textAlign ?? TextAlign.center);
  }
}
