import 'package:starter/common/ui/custom_widgets/app_progress/app_alert_loader.dart';
import 'package:starter/common/utils/localization/common_localizer.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'retry_failed_loading.dart';

class RetryFirstPageFailedLoading extends StatelessWidget {
  final PagingController pagingController;
  final bool isRetryLoading;

  const RetryFirstPageFailedLoading(
      {super.key, required this.pagingController, this.isRetryLoading = false});

  @override
  Widget build(BuildContext context) {
    final String errorMessage = pagingController.error??'';
    return isRetryLoading
        ? const AppAlertProgress()
        : Center(
            child: RetryFailedLoading(
            onRetryPressed: () {
              // don't use.
              // pagingController.notifyPageRequestListeners(1);
              // after pagingController.error = null
              // if use it the two statement together
              // the _pagingController.addPageRequestListener will called twice

              pagingController.error = null;
              pagingController.refresh();
            },
            isRetryLoading: isRetryLoading,
            retryButtonTitle: CommonLocalizer.retry,
            message: errorMessage.isEmpty ? CommonLocalizer.noInternet :errorMessage ,
          ));
  }
}
