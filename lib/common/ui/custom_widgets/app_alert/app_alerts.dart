import 'package:starter/common/ui/app_responsive/app_responsive_scaled_box.dart';
import 'package:starter/common/ui/custom_widgets/app_buttons/app_buttons.dart';
import 'package:starter/common/ui/custom_widgets/app_icons/app_icon.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/localization/common_localizer.dart';
import 'package:flutter/material.dart';

class AppAlerts extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final VoidCallback? primaryButtonTap;
  final bool showCloseButton;
  final String? primaryButtonText;
  final Color? primaryButtonColor;
  final Color? titleColor;
  final double? titleSize;
  final bool? canPop;
  final Widget? footer;
  final Color backgroundColor;
  final Widget? formFieldReview;
  final bool? useIcon;
  final EdgeInsetsGeometry? titlePadding;

  const AppAlerts({
    super.key,
    this.title,
    this.subTitle,
    this.primaryButtonTap,
    this.showCloseButton = true,
    this.primaryButtonText,
    this.canPop,
    this.footer,
    this.formFieldReview,
    this.primaryButtonColor,
    this.titleColor,
    this.titleSize,
    this.titlePadding,
    this.backgroundColor = Colors.white, this.useIcon,
  });

  static void successAlertDialog(context,
      {VoidCallback? onPressSuccess,
      String? title,
      String? subTitle,
      String? primaryButtonText,
      bool? barrierDismissible = true,
      bool? showCloseButton,
      bool? canPop,
      bool useRootNavigator = true,
      Color? primaryButtonColor,
        bool? useIcon,}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      useRootNavigator: useRootNavigator,

      builder: (context) {
        return AppAlerts(
          useIcon: useIcon,
            primaryButtonTap: onPressSuccess,
            showCloseButton: showCloseButton ?? true,
            title: title ?? CommonLocalizer.ok,
            subTitle: subTitle,
            primaryButtonText: primaryButtonText,
            primaryButtonColor: primaryButtonColor,
            canPop: canPop);
      },
    );
  }

  static void showFooterAlert(
    context, {
    required VoidCallback onPrimaryButtonPressed,
    VoidCallback? onSecondaryButtonPressed,
    String? title,
    String? subTitle,
    String? primaryButtonText,
    String? secondaryButtonText,
    bool? showCloseButton,
    bool? canPop,
    bool useRootNavigator = true,
    bool hasCancelButton = false,
    Color? onPrimaryBackgroundColor,
    EdgeInsetsGeometry? titlePadding,
  }) {
    showDialog(
      context: context,
      useRootNavigator: useRootNavigator,
      barrierDismissible: canPop ?? false,
      builder: (context) {
        return AppAlerts(
          titlePadding: titlePadding,
          showCloseButton: showCloseButton ?? false,
          title: title,
          subTitle: subTitle,
          primaryButtonText: CommonLocalizer.confirm,
          canPop: canPop,
          footer: Row(
            children: [
              if (hasCancelButton) ...[
                Expanded(
                  child: AppButton.primaryButton(
                    horizontalPadding: 0,
                    backgroundColor: AppColors.neutral_0,
                    textColor: AppColors.primaryColorsSolid4Default,
                    borderColor: AppColors.primaryColorsSolid4Default,
                    borderWidth: 1.4,
                    onPressed: () {
                      if (onSecondaryButtonPressed != null) {
                        onSecondaryButtonPressed();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    isExpanded: true,
                    textStyle: TextStyles.semiBold(
                        color: AppColors.primaryColorsSolid4Default),
                    title: secondaryButtonText ?? CommonLocalizer.cancel,
                    buttonHeight: Dimensions.buttonMediumHeight,
                  ),
                ),
                const SizedBox(width: PaddingDimensions.medium),
              ],
              Expanded(
                child: AppButton.primaryButton(
                  horizontalPadding: 0,
                  title: primaryButtonText ?? CommonLocalizer.confirm,
                  onPressed: onPrimaryButtonPressed,
                  buttonHeight: Dimensions.buttonMediumHeight,
                  isExpanded: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showAlertWithoutButton(
      context, {
        String? title,
        String? subTitle,
        bool? showCloseButton,
        bool? canPop,
        bool useRootNavigator = true,
        bool hasCancelButton = false,
        EdgeInsetsGeometry? titlePadding,
      }) {
    showDialog(
      context: context,
      useRootNavigator: useRootNavigator,
      barrierDismissible: canPop ?? false,
      builder: (context) {
        return AppAlerts(
          titlePadding: titlePadding,
          showCloseButton: showCloseButton ?? false,
          title: title,
          subTitle: subTitle,
          primaryButtonText: CommonLocalizer.confirm,
          canPop: canPop,
          footer: const SizedBox.shrink()
        );
      },
    );
  }

  static Widget buildVerticalAlert(context,
      {required VoidCallback onPrimaryButtonPressed,
        bool? isSecondaryButtonLoading,
        bool? isPrimaryButtonLoading,
        VoidCallback? onSecondaryPressed,
        String? title,
        String? subTitle,
        String? primaryButtonText,
        String? sceondaryText,
        bool? showCloseButton,
        bool? canPop,
        bool useRootNavigator = true,
        Color? onPrimaryBackgroundColor ,
        Color? onSecondaryBackgroundColor}) {
    return AppAlerts(
        showCloseButton: showCloseButton ?? false,
        title: title,
        titleColor: Colors.black,
        subTitle: subTitle,
        primaryButtonText: CommonLocalizer.confirm,
        canPop: canPop,
        footer: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButton.primaryButton(
                isLoading: isPrimaryButtonLoading ?? false,
                horizontalPadding: 0,
                backgroundColor: onPrimaryBackgroundColor ?? AppColors.neutral_0,
                borderColor: AppColors.primary_400,
                onPressed: () {
                  onPrimaryButtonPressed();
                },
                fontSize: 12,
                textStyle: TextStyles.medium(
                    color: AppColors.neutral_0, fontSize: Dimensions.xLarge),
                isExpanded: true,
                title: primaryButtonText ?? CommonLocalizer.cancel),
            const SizedBox(height: PaddingDimensions.medium),
            AppButton.primaryButton(
                isLoading: isSecondaryButtonLoading ?? false,
                horizontalPadding: 0,
                verticalPadding: 0,
                backgroundColor: onSecondaryBackgroundColor,
                borderColor: AppColors.primaryColorsSolid4Default,
                onPressed: onSecondaryPressed,
                isExpanded: true,
                textStyle:
                TextStyles.medium(color: AppColors.primaryColorsSolid4Default, fontSize: Dimensions.xLarge),
                title: sceondaryText ?? CommonLocalizer.confirm),
          ],
        ));
  }

  static void showVerticalAlert(context,
      {required VoidCallback onPrimaryButtonPressed,
      bool? isCancelButtonLoading,
      bool? isConfirmButtonLoading,
      VoidCallback? onCancelPressed,
      String? title,
      double? titleSize,
      String? subTitle,
      String? primaryButtonText,
      String? cancelText,
      bool? showCloseButton,
      bool? canPop,
      EdgeInsetsGeometry? titlePadding,
        bool useRootNavigator = true,
      Color? onPrimaryBackgroundColor}) {
    showDialog(
      context: context,
      useRootNavigator: useRootNavigator,
      barrierDismissible: true,
      builder: (context) {
        return AppAlerts(
          titlePadding :titlePadding,
          showCloseButton: showCloseButton ?? false,
          title: title,
          titleSize: titleSize,
          subTitle: subTitle,
          primaryButtonText: CommonLocalizer.confirm,
          canPop: canPop,
          footer: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppButton.primaryButton(
                title: primaryButtonText ?? CommonLocalizer.confirm,
                isLoading: isConfirmButtonLoading ?? false,
                color: onPrimaryBackgroundColor,
                fontSize: Dimensions.xLarge,
                horizontalPadding: 0,
                isExpanded: true,
                onPressed: onPrimaryButtonPressed,
              ),
              const SizedBox(height: PaddingDimensions.medium),
              AppButton.outlinedButton(
                title: cancelText ?? CommonLocalizer.cancel,
                buttonHeight: Dimensions.buttonMediumHeight,
                isExpanded: true,
                fontSize: Dimensions.xLarge,
                isLoading: isConfirmButtonLoading ?? false,
                color: onPrimaryBackgroundColor,
                onPressed: () {
                  if (onCancelPressed != null) {
                    onCancelPressed();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static const double _alertRadius = 16.0;
  static final RoundedRectangleBorder _alertRectangleBorder =
      RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(_alertRadius),
  );

  @override
  Widget build(BuildContext context) {
    return AppResponsiveScaledBox(
      child: PopScope(
        canPop: canPop ?? true,
        child: AlertDialog(

          insetPadding: const EdgeInsets.all(PaddingDimensions.large),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: PaddingDimensions.xxLarge,
          ),
          shape: _alertRectangleBorder,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,

          titlePadding: const EdgeInsetsDirectional.only(
            start: PaddingDimensions.large,
            top: PaddingDimensions.xLarge,
          ),
          title: Row(
            children: [
              showCloseButton
                  ? InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(24),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.close,
                          color: AppColors.neutral_200,
                          size: 24,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              title != null
                  ? Expanded(
                      child: Padding(
                        padding:titlePadding?? const EdgeInsetsDirectional.only(
                            end: PaddingDimensions.xLarge),
                        child: Text(
                          title!,
                          textAlign: TextAlign.center,
                          style: TextStyles.semiBold(
                            fontSize: titleSize ?? Dimensions.xxxLarge,
                            color: titleColor ?? AppColors.neutralColors7,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if(useIcon==true)...[
                   const  Center(child: AppIcons(imagePath: 'test',))
                  ],
                  const SizedBox(height: PaddingDimensions.normal),
                  subTitle != null
                      ? Row(
                          children: [
                            Expanded(
                              child: Text(
                                subTitle!,
                                textAlign: TextAlign.center,
                                style: TextStyles.regular(
                                  //  height: 1.3,
                                  fontSize: Dimensions.xLarge,
                                  color: AppColors.neutralColors7,
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: PaddingDimensions.xxLarge,
                  ),
                  footer != null
                      ? footer!
                      : AppButton.primaryButton(
                          horizontalPadding: 0,
                          onPressed: primaryButtonTap,
                          borderColor: AppColors.primaryColorsSolid4Default,
                          isExpanded: true,
                          buttonHeight: Dimensions.buttonMediumHeight,
                          backgroundColor: primaryButtonColor ??
                              AppColors.primaryColorsSolid4Default,
                          title: primaryButtonText ?? CommonLocalizer.confirm,
                        ),
                  const SizedBox(
                    height: PaddingDimensions.xLarge,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
