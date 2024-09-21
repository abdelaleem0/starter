import 'package:flutter/material.dart';

class DisableOverscrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    // eliminate any behavior in Scrolling just return the child only.
    return child;
  }
}