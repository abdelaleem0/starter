import 'package:starter/common/ui/app_responsive/responsive_scale_helpers.dart';
import 'package:flutter/material.dart';

class MediaQueryScaleOverrider extends StatelessWidget {
  final Widget child;
  const MediaQueryScaleOverrider({super.key, required this.child,});

  @override
  Widget build(BuildContext context) {
    final width = ResponsiveScaleHelper.getScaledWidth(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        MediaQueryData mediaQueryData = MediaQuery.of(context);

        double aspectRatio = constraints.maxWidth / constraints.maxHeight;
        double scaledWidth = width;
        double scaledHeight = width / aspectRatio;

        EdgeInsets scaledViewInsets = ResponsiveScaleHelper.getScaledViewInsets(
            mediaQueryData: mediaQueryData,
            screenSize: mediaQueryData.size,
            scaledSize: Size(scaledWidth, scaledHeight));
        EdgeInsets scaledViewPadding = ResponsiveScaleHelper.getScaledViewPadding(
            mediaQueryData: mediaQueryData,
            screenSize: mediaQueryData.size,
            scaledSize: Size(scaledWidth, scaledHeight));
        EdgeInsets scaledPadding = ResponsiveScaleHelper.getScaledPadding(
            padding: scaledViewPadding, insets: scaledViewInsets);

        return MediaQuery(
          data: mediaQueryData.copyWith(
            size: Size(scaledWidth, scaledHeight),
            viewInsets: scaledViewInsets,
            viewPadding: scaledViewPadding,
            padding: scaledPadding,
          ),
          child: child,
        );
      },
    );
  }


}
