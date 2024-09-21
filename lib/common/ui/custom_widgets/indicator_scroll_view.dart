import 'package:starter/common/utils/remove_bluish_scroll_glow.dart';
import 'package:flutter/material.dart';

import '../custom_scrollbar.dart';

class IndicatorScrollView extends StatelessWidget {
  final ScrollController scrollController;
  final Widget child;
  final Color? scrollbarColor;

  const IndicatorScrollView(
      {super.key,
      required this.scrollController,
      required this.child,
      this.scrollbarColor});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: RemoveBluishScrollGlow(),
      child: CustomScrollbarWidget(
        scrollController: scrollController,
        scrollbarColor: scrollbarColor,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          controller: scrollController,
          child: child,
        ),
      ),
    );
  }
}
