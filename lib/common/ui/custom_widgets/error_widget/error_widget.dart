import 'package:starter/common/ui/custom_widgets/app_buttons/app_buttons.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/assets_paths/animated_json_paths.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/localization/common_localizer.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';

class NewPageRetryErrorWidget extends StatefulWidget {
  final String message;
  final void Function() onPressed;


  const NewPageRetryErrorWidget({
    super.key,
    required this.message,
    required this.onPressed,
  });

  @override
  State<NewPageRetryErrorWidget> createState() =>
      _NewPageRetryErrorWidgetState();
}

class _NewPageRetryErrorWidgetState extends State<NewPageRetryErrorWidget> {
  late ImageProvider imagePath;
  bool isLoading = false;
  bool isRetryEnabled = true;

  void _retryFailedLoading() {
    if (!isRetryEnabled) {
      return; // Ignore button press if retry is disabled
    }

    setState(() {
      isLoading = true;
      isRetryEnabled = false;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
        isRetryEnabled = true;
      });
      internetConnection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildFailureBody();
  }

  Widget _buildFailureBody() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        color: AppColors.neutralColors1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              AnimatedJsonPaths.paginationFailure,
            ),
            const SizedBox(
              height: PaddingDimensions.xxxLarge,
            ),
            Text(
              textAlign: TextAlign.center,
              "Oops! Something Went Wrong", //todo 2024
              style: TextStyles.semiBold(
                fontSize: Dimensions.xxLarge,
                color: AppColors.neutralColors7,
              ),
            ),
            const SizedBox(
              height: PaddingDimensions.normal,
            ),
            Text(
              textAlign: TextAlign.center,
              "Looks like we hit an unexpected error. Please try again",
              style: TextStyles.regular(
                fontSize: Dimensions.large,
                color: AppColors.neutralColors7,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: PaddingDimensions.xxLarge,
                  horizontal: PaddingDimensions.x4Large),
              child: AppButton.primaryButton(
                isLoading: isLoading,
                horizontalPadding: 1,
                isExpanded: true,
                color: AppColors.neutral_700,
                isBold: false,
                isShadow: false,
                title: CommonLocalizer.retry,
                buttonHeight: 40,
                onPressed: isLoading ? null : _retryFailedLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> internetConnection() async {
    widget.onPressed();
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected) {
      widget.onPressed();
    }
  }
}
