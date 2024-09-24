import 'package:starter/common/ui/custom_widgets/app_icons/app_icon.dart';
import 'package:starter/common/ui/custom_widgets/app_buttons/app_buttons.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/assets_paths/svg_paths.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CompleteDialogPage extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onPressedContinue;

  const CompleteDialogPage({super.key, required this.title, required this.description, required this.onPressedContinue});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Opacity(
                opacity: 0.5,
                child: ModalBarrier(
                  dismissible: false,
                  color: AppColors.neutral_900.withOpacity(1),
                ),
              ),
              Center(
                child: Padding(
                  padding:  const EdgeInsets.symmetric(horizontal: PaddingDimensions.large),
                  child: Container(
                    decoration: BoxDecoration(color: AppColors.neutral_0,borderRadius: BorderRadius.circular(24)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                      padding:  const EdgeInsets.all(PaddingDimensions.large),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const AppIcons(
                            imagePath: SvgPaths.AppLogo,
                            height: 50,
                            width: 50,
                          ),
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyles.bold(
                                color: AppColors.neutral_700, fontSize: Dimensions.large),
                          ),
                          const SizedBox(
                            height: PaddingDimensions.small,
                          ),
                          Text(
                            description,
                            style: TextStyles.regular(
                                color: AppColors.neutral_700, fontSize: Dimensions.normal),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: PaddingDimensions.large,
                          ),
                          AppButton.defaultButton(
                              gradiantColors: AppColors.gradient_1,
                              isBold: false,
                              isShadow: false,
                              fontSize: Dimensions.normal,
                              horizontalPadding: PaddingDimensions.xxLarge,
                              title: "Continue",
                              textColor: AppColors.neutral_0,
                              onPressed: onPressedContinue),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }

}
