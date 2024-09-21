import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';

class PaddingAllSidesWithoutBottom extends StatelessWidget {
  final Widget child;
  final bool? withoutBottom;
  final double? topPadding;

  const PaddingAllSidesWithoutBottom({
    super.key,
    required this.child,
    this.withoutBottom,
    this.topPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: topPadding ??0,
        bottom: (withoutBottom == true) ? 0 : PaddingDimensions.xLarge,
        left: PaddingDimensions.xxLarge,
        right: PaddingDimensions.xxLarge,
      ),
      child: child,
    );
  }
}
