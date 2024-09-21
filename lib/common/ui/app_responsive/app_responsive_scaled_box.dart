import 'package:starter/common/ui/app_responsive/responsive_scale_helpers.dart';
import 'package:flutter/material.dart';

class AppResponsiveScaledBox extends StatelessWidget {
  final Widget child;
  final bool useDynamicHeight;
  final bool calculateMediaQuery;
  final double? scaleWidth;
  final AlignmentGeometry? alignment;

  const AppResponsiveScaledBox({super.key, required this.child,this.useDynamicHeight = false, this.calculateMediaQuery = true, this.scaleWidth, this.alignment});

  @override
  Widget build(BuildContext context) {
    final width = scaleWidth ?? ResponsiveScaleHelper.getScaledWidth(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        MediaQueryData mediaQueryData = MediaQuery.of(context);

        double aspectRatio = constraints.maxWidth / constraints.maxHeight;
        double scaledWidth = width;
        double scaledHeight = width / aspectRatio;

        bool overrideMediaQueryData = (mediaQueryData.size ==
            Size(constraints.maxWidth, constraints.maxHeight)) && calculateMediaQuery;

        Widget childHolder = FittedBox(
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
          child: Container(
            width: width,
            height: useDynamicHeight ? null : scaledHeight,
            alignment: alignment ?? Alignment.center,
            child: child,
          ),
        );

        if (overrideMediaQueryData) {
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
                padding: scaledPadding),
            child: childHolder,
          );
        }

        return childHolder;
      },
    );
  }
}
