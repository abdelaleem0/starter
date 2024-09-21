import 'package:starter/common/ui/custom_widgets/app_loading/loading_widget_v2.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:flutter/material.dart';


class AppAlertProgress extends StatefulWidget {
  const AppAlertProgress(
      {super.key,
      this.color = AppColors.primaryColor,
        this.size = 88,
      this.progressStrokeWidth = 4.0});
  final Color color;
  final double progressStrokeWidth;
  final double size;

  static void showLoader(context, {bool useRootNavigator = true}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: useRootNavigator,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: AppColors.forthColor,
                  borderRadius: BorderRadius.circular(8)),
              child: const CircularProgressIndicator.adaptive(
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                strokeWidth: 4.0,
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget loader() {
    return const Center(
        child: Center(
            child: CircularProgressIndicator(
      color: AppColors.primaryColor,
    )));
  }

  static void logo(context, {bool useRootNavigator = true}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: useRootNavigator,
      builder: (context) {
        return WillPopScope(
            onWillPop: () async => false, child: const AppAlertProgress());
      },
    );
  }

  @override
  State<AppAlertProgress> createState() => _AppAlertProgressState();
}

class _AppAlertProgressState extends State<AppAlertProgress> {


  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: widget.size,
        width: widget.size,
        child: const LoadingWidgetV2(),
      ),
    );
  }
}
