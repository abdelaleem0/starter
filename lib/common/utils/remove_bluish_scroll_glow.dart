import 'package:flutter/material.dart';

class RemoveBluishScrollGlow extends ScrollBehavior {

  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
