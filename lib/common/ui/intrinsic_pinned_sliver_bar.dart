import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class IntrinsicPinnedSliverBar extends SingleChildRenderObjectWidget {
  const IntrinsicPinnedSliverBar({super.key, required super.child});
  @override
  RenderObject createRenderObject(BuildContext context) => _RenderCustomSliverPersistentHeader();
}
class _RenderCustomSliverPersistentHeader extends RenderSliverPinnedPersistentHeader {
  _RenderCustomSliverPersistentHeader();
  @override
  double get maxExtent =>
      child!.getMaxIntrinsicHeight(constraints.crossAxisExtent);
  @override
  double get minExtent =>
      child!.getMaxIntrinsicHeight(constraints.crossAxisExtent);
}