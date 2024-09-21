import 'dart:math';

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveScaleHelper{
  ResponsiveScaleHelper._();
  static double getScaledWidth(BuildContext context){
    return ResponsiveValue<double>(context, conditionalValues: const [
      Condition.between(start: 0, end: 360, value: 320, landscapeValue: 500),
      Condition.between(start: 360, end: 450, value: 375, landscapeValue: 500),
      Condition.between(start: 450, end: 800, value: 500, landscapeValue: 750),
      Condition.between(start: 800, end: 1100, value: 530, landscapeValue: 850),
      Condition.between(start: 1100, end: 1400, value: 640,landscapeValue: 880),
      Condition.between(start: 1400, end: 9999, value: 700, landscapeValue: 1100),
    ]).value;
  }

  static Offset adjustPositionForScaledUI(BuildContext context, Offset position){
    final RenderBox? renderObject = context.findRenderObject() as RenderBox?;
    return renderObject?.globalToLocal(
      Offset(
        position.dx,
        position.dy,
      ),
    ) ?? position;
  }

  static EdgeInsets getScaledViewInsets(
      {required MediaQueryData mediaQueryData,
        required Size screenSize,
        required Size scaledSize}) {
    double leftInsetFactor = mediaQueryData.viewInsets.left / screenSize.width;
    double topInsetFactor = mediaQueryData.viewInsets.top / screenSize.height;
    double rightInsetFactor =
        mediaQueryData.viewInsets.right / screenSize.width;
    double bottomInsetFactor =
        mediaQueryData.viewInsets.bottom / screenSize.height;

    double scaledLeftInset = leftInsetFactor * scaledSize.width;
    double scaledTopInset = topInsetFactor * scaledSize.height;
    double scaledRightInset = rightInsetFactor * scaledSize.width;
    double scaledBottomInset = bottomInsetFactor * scaledSize.height;

    return EdgeInsets.fromLTRB(
        scaledLeftInset, scaledTopInset, scaledRightInset, scaledBottomInset);
  }

  static EdgeInsets getScaledViewPadding(
      {required MediaQueryData mediaQueryData,
        required Size screenSize,
        required Size scaledSize}) {
    double scaledLeftPadding;
    double scaledTopPadding;
    double scaledRightPadding;
    double scaledBottomPadding;

    double leftPaddingFactor =
        mediaQueryData.viewPadding.left / screenSize.width;
    double topPaddingFactor =
        mediaQueryData.viewPadding.top / screenSize.height;
    double rightPaddingFactor =
        mediaQueryData.viewPadding.right / screenSize.width;
    double bottomPaddingFactor =
        mediaQueryData.viewPadding.bottom / screenSize.height;

    scaledLeftPadding = leftPaddingFactor * scaledSize.width;
    scaledTopPadding = topPaddingFactor * scaledSize.height;
    scaledRightPadding = rightPaddingFactor * scaledSize.width;
    scaledBottomPadding = bottomPaddingFactor * scaledSize.height;

    return EdgeInsets.fromLTRB(scaledLeftPadding, scaledTopPadding,
        scaledRightPadding, scaledBottomPadding);
  }

  static EdgeInsets getScaledPadding(
      {required EdgeInsets padding, required EdgeInsets insets}) {
    double scaledLeftPadding;
    double scaledTopPadding;
    double scaledRightPadding;
    double scaledBottomPadding;

    scaledLeftPadding = max(0.0, padding.left - insets.left);
    scaledTopPadding = max(0.0, padding.top - insets.top);
    scaledRightPadding = max(0.0, padding.right - insets.right);
    scaledBottomPadding = max(0.0, padding.bottom - insets.bottom);

    return EdgeInsets.fromLTRB(scaledLeftPadding, scaledTopPadding,
        scaledRightPadding, scaledBottomPadding);
  }
}
