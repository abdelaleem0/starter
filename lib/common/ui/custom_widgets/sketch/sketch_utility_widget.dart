import 'package:starter/common/ui/custom_widgets/sketch/share_widget.dart';
import 'package:starter/common/ui/download_view/download_widget.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';

class SketchUtilityWidget extends StatelessWidget {
  final bool isHome;
  final String id;
  final String sketchPdfIdentifier;
  final String sketchImageIdentifier;

  /// The [completeCallback] worked only if isHome false.
  /// When you coming from the question itself not from home.
  final VoidCallback? completeCallback;

  const SketchUtilityWidget(
      {super.key,
      required this.isHome,
      required this.id,
      required this.sketchPdfIdentifier,
      required this.sketchImageIdentifier,
      this.completeCallback});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DownloadWidget(
          sketchId: id,
          sketchPdfIdentifier: sketchPdfIdentifier,
          sketchImageIdentifier: sketchImageIdentifier,
        ),
        const SizedBox(width: PaddingDimensions.normal),
        ShareWidget(
          sketchId: id,
          sketchPdfIdentifier: sketchPdfIdentifier,
          sketchImageIdentifier: sketchImageIdentifier,
        ),
      ],
    );
  }
}
