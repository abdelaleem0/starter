import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/extensions/media_query.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class AppDivider extends StatelessWidget {
  final double thickness;
  final double? top;
  final double? bottom;
  final double? start;
  final double? end;

  final bool forceWidthOverflow;
  final Color color;

  const AppDivider({
    super.key,
    this.thickness = 1,
    this.top,
    this.bottom,
    this.forceWidthOverflow = false,
    this.color = AppColors.neutralColors3,
    this.start,
    this.end,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: top ?? PaddingDimensions.large,
        bottom: bottom ?? PaddingDimensions.large,
        start: start ?? 0,
        end: end ?? 0
      ),
      child: forceWidthOverflow
      ? SizedBox(
        width: context.width,
        height: thickness,
        child: OverflowBox(
          minWidth: context.width,
          maxWidth: context.width,
          child: Divider(
            thickness: thickness,
            color: color,
          ),
        ),
      )
      : Divider(
        thickness: thickness,
        color: color,
        height: thickness,
      )
    );
  }
}