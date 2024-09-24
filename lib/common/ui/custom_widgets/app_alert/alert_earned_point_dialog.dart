import 'package:starter/common/ui/custom_widgets/app_buttons/app_buttons.dart';
import 'package:starter/common/ui/custom_widgets/app_icons/app_icon.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/assets_paths/svg_paths.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';

class AlertEarnedPointDialog extends StatelessWidget {
  final String alertTitle;
  final String alertDescription;
  final String buttonTitle;
  final double earnedAmount;
  final Function onPressSuccess;

  const AlertEarnedPointDialog(
      {super.key,
      required this.onPressSuccess,
      required this.alertTitle,
      required this.alertDescription,
      required this.buttonTitle,
      required this.earnedAmount});

  static void showEarnedPointsAlertDialog(
      context,
      Function onPressSuccess,
      String alertTitle,
      String alertDescription,
      String buttonTitle,
      double earnedAmount) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            icon: const AppIcons(
              imagePath: SvgPaths.AppLogo,
              height: 50,
              width: 50,
            ),
            content: AlertEarnedPointDialog(
              onPressSuccess: onPressSuccess,
              alertTitle: alertTitle,
              alertDescription: alertDescription,
              buttonTitle: buttonTitle,
              earnedAmount: earnedAmount,
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          alertTitle,
          textAlign: TextAlign.center,
          style: TextStyles.bold(
              color: AppColors.neutral_700, fontSize: Dimensions.large),
        ),
        const SizedBox(
          height: PaddingDimensions.small,
        ),
        Text(
          alertDescription,
          style: TextStyles.regular(
              color: AppColors.neutral_700, fontSize: Dimensions.normal),
          textAlign: TextAlign.center,
        ),
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: TextStyles.regular(
                  fontSize: Dimensions.normal,
                  color: AppColors.neutral_700,
                ),
                children: [
                  TextSpan(text: "You have also just earned",style: TextStyles.regular(
                    color: AppColors.primary_500,
                    fontSize: Dimensions.normal,
                  )),
                  TextSpan(
                      text: ' $earnedAmount Points Congratulation! ',
                      style: TextStyles.regular(
                        color: AppColors.primary_500,
                        fontSize: Dimensions.normal,
                      )),
                ])),
        const SizedBox(
          height: PaddingDimensions.large,
        ),
        AppButton.defaultButton(
            gradiantColors: AppColors.gradient_1,
            // color: AppColors.neutral_700,
            // backgroundColor: AppColors.neutral_0,
            isBold: false,
            isShadow: false,
            fontSize: Dimensions.normal,
            horizontalPadding: PaddingDimensions.xxLarge,
            title: buttonTitle,
            textColor: AppColors.neutral_0,
            onPressed: () {
              Navigator.pop(context);
              onPressSuccess();
            }),
      ],
    );
  }
}
