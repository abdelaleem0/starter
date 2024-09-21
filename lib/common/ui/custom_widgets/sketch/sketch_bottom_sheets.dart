import 'package:starter/common/ui/download_view/download_view_cubit.dart';
import 'package:starter/common/utils/app_snakbars_and_alerts/show_Download_sketch_bottom_sheet.dart';
import 'package:starter/common/utils/common.dart';
import 'package:starter/common/utils/constants.dart';
import 'package:starter/common/utils/localization/common_localizer.dart';
import 'package:flutter/material.dart';

class ContentActionBottomSheets {
  static void showShareBottomSheet({
      required BuildContext context,
      required String sketchPdfIdentifier,
      required String sketchImageIdentifier,
      required String sketchId}) {
    ShowDownloadSketchBottomSheet.show(
        context: context,
        onImagePrimaryButtonTap: ()=> _shareImage(sketchImageIdentifier, sketchId),
        onPdfPrimaryButtonTap: ()=> _sharePdf(sketchPdfIdentifier, sketchId),
        title: CommonLocalizer.shareText);
  }

  static void showDownloadBottomSheet(
      {required BuildContext context,
      required String sketchPdfIdentifier,
      required String sketchImageIdentifier,
      required String sketchId}) {
    ShowDownloadSketchBottomSheet.show(
      context: context,
      onImagePrimaryButtonTap: () =>
          _downloadImageSketch(context, sketchImageIdentifier, sketchId),
      onPdfPrimaryButtonTap: () =>
          _downloadPdfSketch(context, sketchPdfIdentifier, sketchId),
      title: CommonLocalizer.downloadAsText,
    );
  }
}

_downloadPdfSketch(
    BuildContext context, String sketchPdfIdentifier, String sketchId) {
  DownloadViewCubit.get(context)
      .downloadPdfSketch(sketchIdentifier: sketchPdfIdentifier, id: sketchId);
}

_downloadImageSketch(
    BuildContext context, String sketchImageIdentifier, String sketchId) {
  DownloadViewCubit.get(context).downloadImageSketch(
      sketchIdentifier: sketchImageIdentifier, id: sketchId);
}

_shareImage(String sketchImageIdentifier, String sketchId) {
  shareLink(Constants.baseUrl + sketchImageIdentifier + sketchId);
}

_sharePdf(String sketchPdfIdentifier, String sketchId) {
  shareLink(Constants.baseUrl + sketchPdfIdentifier + sketchId);
}
