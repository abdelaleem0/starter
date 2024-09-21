import 'package:starter/common/ui/custom_widgets/app_buttons/app_buttons.dart';
import 'package:starter/common/utils/app_routes/router_functions.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/custom_widgets/application_app_bars.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String imagePath;
  final String? buttonText;
  final Function()? onButtonPressed;
  final String appBarTitle;
  final bool? withAppBar;
  final double? buttonInnerPaddeing;

  const EmptyListWidget(
      {super.key,
        required this.title,
        this.subtitle,
        required this.imagePath,
        required this.buttonText,
        this.onButtonPressed,
        required this.appBarTitle, this.withAppBar=true, this.buttonInnerPaddeing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: withAppBar==true?ApplicationAppBars.defaultAppBar(
        context: context,
        title: appBarTitle,
        useCloseButton: true,
        onBackPressed: () {
          AppRouteNavigator.pop(context);
        },
      ):null,
      body: Padding(
        padding: const EdgeInsets.only(bottom: PaddingDimensions.x7Large-10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: PaddingDimensions.x5Large),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Image(
                        width: 152,
                        height: 152,
                        fit: BoxFit.contain,
                        image: AssetImage(imagePath),
                      ),
                    ),
                    const SizedBox(height: PaddingDimensions.xxLarge),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyles.semiBold(
                        height: 1.2,
                        color: AppColors.neutralColors7,
                        fontSize: Dimensions.xxxxLarge,
                      ),
                    ),
                    const SizedBox(height: PaddingDimensions.xxLarge),
                    AppButton.primaryButton(
                      isExpanded: true,
                      buttonHeight: Dimensions.largeDisplay,
                      title: buttonText ?? '',
                      horizontalPadding: buttonInnerPaddeing??PaddingDimensions.x7Large - 10,
                      onPressed: () {
                        if (onButtonPressed != null) {
                          onButtonPressed!();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
