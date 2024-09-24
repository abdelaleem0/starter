import 'package:starter/common/ui/custom_widgets/app_icons/app_icon.dart';
import 'package:starter/common/utils/assets_paths/svg_paths.dart';
import 'package:flutter/material.dart';
import 'package:starter/common/ui/custom_widgets/app_buttons/app_buttons.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/localization/common_localizer.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RetryFailedLoading extends StatelessWidget {
  final String message;
  final String retryButtonTitle;
  final VoidCallback onRetryPressed;
  final bool isRetryLoading;

  RetryFailedLoading({
    super.key,
    String? message,
    String? retryButtonTitle,
    required this.onRetryPressed,
    this.isRetryLoading = false,
  })  : message = message ?? CommonLocalizer.noInternet,
        retryButtonTitle = retryButtonTitle ??  CommonLocalizer.retry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppIcons.getSvgIcon(imagePath: SvgPaths.AppLogo, size: 64),
        const SizedBox(
          height: 16,
        ),
        Text(
          message,
          style: TextStyles.semiBold(
              color: AppColors.textPrimaryColor, fontSize: Dimensions.large),
        ),
        const SizedBox(
          height: 16,
        ),
        AppButton.primaryButton(
          title: retryButtonTitle,
          onPressed: onRetryPressed,
          isLoading: isRetryLoading,
          buttonHeight: Dimensions.buttonMediumHeight,
          horizontalPadding: 16,
        ),
      ],
    );
  }

  /// don't make pagingController.retryLastFailedRequest();
  /// it done here inside the method
  static Widget getPaginationIndicatorError(
      PagingController pagingController){
    return Center(
      child: AppButton.primaryButton(
        title: CommonLocalizer.retry,
        onPressed: () {
          pagingController.retryLastFailedRequest();

        },
      ),
    );
  }
}
