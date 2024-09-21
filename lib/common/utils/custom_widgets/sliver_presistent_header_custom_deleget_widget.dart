import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';

class PersistentHeaderCustomDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;

  double height = 0;

  PersistentHeaderCustomDelegate({required this.widget, this.height = 0});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.neutral_0,
      width: double.infinity,
      height: Dimensions.toolbarHeight + height,
      child: Center(child: widget),
    );
  }

  @override
  double get maxExtent => 54.0 + height;

  @override
  double get minExtent => 54.0 + height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
