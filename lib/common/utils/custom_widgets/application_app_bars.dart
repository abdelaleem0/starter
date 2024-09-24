import 'package:starter/common/ui/custom_widgets/app_icons/adaptive_icon.dart';
import 'package:starter/common/ui/custom_widgets/app_icons/app_icon.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/assets_paths/svg_paths.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';

class ApplicationAppBars {
  ApplicationAppBars._();

  static AppBar leadingBarWithAppIcon({
    String? title,
    String? subTitle,
    BuildContext? context,
    VoidCallback? onBackPressed,
    List<Widget>? actions,
    double? titleSpacing,
    bool closeIconBorder = false,
    Color tintColor = AppColors.neutral_900,
    bool useCloseButton = false,
  }) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      titleSpacing: useCloseButton ? titleSpacing ?? -6 : null,
      automaticallyImplyLeading: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppIcons(
            imagePath: SvgPaths.AppLogo,
            width: IconDimensions.medium,
            height: IconDimensions.medium,
            color: AppColors.neutralColors1,
          ),
          const SizedBox(
            width: PaddingDimensions.normal,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title??"",
                style: TextStyles.medium(
                  fontSize: Dimensions.xxLarge,
                  color: AppColors.neutralColors1,
                ),
              ),
              Text(
                subTitle??'',
                style: TextStyles.regular(
                  fontSize: Dimensions.large,
                  color: AppColors.neutralColors1,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: actions,
      leading: useCloseButton
          ? GestureDetector(
        child: LangAdaptiveIcon(
          child: CircleAvatar(
            backgroundColor: closeIconBorder
                ? AppColors.backgroundColor.withOpacity(0.2)
                : Colors.transparent,
            maxRadius: 12,
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: tintColor,
              size: IconDimensions.medium,
            ),
          ),
        ),
        onTap: () {
          if (context != null) {
            if (onBackPressed != null) {
              onBackPressed();
            } else {
              _onBackPressed(context);
            }
          }
        },
      )
          : null,
    );
  }

  static AppBar defaultAppBar({
    String? title,
    required BuildContext? context,
    VoidCallback? onBackPressed,
    Color tintColor = AppColors.neutralColors7,
    bool useCloseButton = false,
    bool centerTitle = false,
    double? elevation,
    double? titleSpacing,
    Color? backgroundColor,
    List<Widget>? actions,
    bool closeIconBorder = false,
    double? fontSize,
    double? toolBarHeight,
  }) {
    return AppBar(
      toolbarHeight: toolBarHeight ?? Dimensions.toolbarHeight,
      backgroundColor: backgroundColor ?? AppColors.neutral_0,
      elevation: elevation ?? 0,
      centerTitle: centerTitle,
      titleSpacing: useCloseButton ? titleSpacing ?? -6 : null,
      leading: useCloseButton
          ? GestureDetector(
              child: LangAdaptiveIcon(
                child: CircleAvatar(
                  backgroundColor: closeIconBorder
                      ? AppColors.backgroundColor.withOpacity(0.2)
                      : Colors.transparent,
                  maxRadius: 12,
                  child: AppIcons(
                    imagePath: SvgPaths.backButton,
                    color: tintColor,
                  ),
                ),
              ),
              onTap: () {
                if (context != null) {
                  if (onBackPressed != null) {
                    onBackPressed();
                  } else {
                    _onBackPressed(context);
                  }
                }
              },
            )
          : null,
      actions: actions,
      automaticallyImplyLeading: false,
      title: title != null
          ? Text(
              title,
              style: TextStyles.semiBold(
                color: tintColor,
                fontSize: fontSize ?? Dimensions.xxxLarge,
              ),
              overflow: TextOverflow.ellipsis,
            )
          : null,
    );
  }

  static AppBar authAppBar(
      {String? title,
      BuildContext? context,
      VoidCallback? onBackPressed,
      Color tintColor = AppColors.neutral_900,
      bool useCloseButton = false,
      VoidCallback? onTap}) {
    return AppBar(
      backgroundColor: AppColors.neutral_0,
      elevation: 0,
      leading: useCloseButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: tintColor,
              ),
              onPressed: () {
                if (context != null) {
                  if (onBackPressed != null) {
                    onBackPressed();
                  } else {
                    _onBackPressed(context);
                  }
                }
              },
            )
          : const SizedBox(),
      actions: [
        GestureDetector(
          onTap: onTap,
          child: Center(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                end: PaddingDimensions.xxLarge,
              ),
              child: Text(
                title ?? '',
                style: TextStyles.boldUnderlined(
                    fontSize: Dimensions.xxLarge, color: AppColors.neutral_500),
              ),
            ),
          ),
        )
      ],
    );
  }

  static AppBar homeAppBar({
    required List<Widget>? actions,
    required Widget title,
    required Widget leading,
    required BuildContext context,
  }) {
    return AppBar(
      centerTitle: true,
      toolbarHeight: Dimensions.toolbarHeight + 20,
      elevation: 0,
      backgroundColor: AppColors.forthColor,
      shadowColor: Colors.transparent,
      title: title,
      leading: leading,
      actions: actions,
    );
  }

  static void _onBackPressed(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
