
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AlreadyOrDontHaveAccount extends StatelessWidget {
  const AlreadyOrDontHaveAccount(
      {super.key,
      required this.text,
      required this.clickableText,
      required this.onTap});

  final String text;
  final String clickableText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: text,
          style: TextStyles.regular(
            fontSize: Dimensions.xxLarge,
            color: AppColors.neutralColors5,
          ),
          children: <TextSpan>[
            TextSpan(
              text: "\t$clickableText",
              style: TextStyles.medium(
                fontSize: Dimensions.xxLarge,
                height: 1.6,
                color: AppColors.primary_400,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            )
          ],
        ),
      ),
    );
  }
}
