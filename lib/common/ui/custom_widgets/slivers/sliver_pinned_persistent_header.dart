import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliverPinnedBoxAdapter extends SingleChildRenderObjectWidget {
  @override
  final Widget child;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderSliverPinnedBoxAdapter();
  }

  const SliverPinnedBoxAdapter({
    required this.child,
    super.key,
  }) : super(child: child);
}

class _RenderSliverPinnedBoxAdapter extends RenderSliverSingleBoxAdapter {
  _RenderSliverPinnedBoxAdapter();
  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }

    child?.layout(constraints.asBoxConstraints(), parentUsesSize: true);
    double childExtent;
    switch (constraints.axis) {
      case Axis.horizontal:
        childExtent = child?.size.width ?? 0;
        break;
      case Axis.vertical:
        childExtent = child?.size.height  ?? 0;
        break;
    }


    final double paintedChildSize =
    calculatePaintOffset(constraints, from: 0.0, to: childExtent);
    final double cacheExtent =
    calculateCacheOffset(constraints, from: 0.0, to: childExtent);

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);

    geometry = SliverGeometry(
      scrollExtent: childExtent,
      paintExtent: paintedChildSize,
      cacheExtent: cacheExtent,
      maxPaintExtent: childExtent,
      hitTestExtent: childExtent,
      hasVisualOverflow: childExtent > constraints.remainingPaintExtent ||
          constraints.scrollOffset > 0.0,
      paintOrigin: constraints.overlap,
      visible: true,
    );
  }


  @override
  double childMainAxisPosition(RenderBox child) => constraints.overlap;

}
