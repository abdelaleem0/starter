import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';

extension ShapBorderX<T extends Widget> on T {
  Container roundedRectangleBorder({
    double? radius,
    Color? backgroundColor,
    List<Color>? gradiantColors,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    Color? borderColor,
    Color? shadowColor,
    double? horizontalMargin,
    double? horizontalPadding,
    double? verticalPadding,
    double? borderWidth,
    double? verticalMargin,
    bool isShadow = false,
    bool isExpanded = false,
    BorderRadiusGeometry? borderRadius,
  }) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin ?? PaddingDimensions.normal,
        vertical: verticalMargin ?? PaddingDimensions.normal,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? PaddingDimensions.normal,
          vertical: verticalPadding ?? PaddingDimensions.normal),
      width: isExpanded ? double.infinity : null,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.neutralColors2,
        gradient: gradiantColors == null
            ? null
            : LinearGradient(
          colors: gradiantColors,
          begin: begin ?? Alignment.topLeft,
          end: end ?? Alignment.bottomCenter,
        ),
        border: Border.all(
            color: borderColor ?? AppColors.neutralColors3, width: borderWidth ?? 1),
        borderRadius:borderRadius?? BorderRadius.circular(radius ?? 14),
        boxShadow: isShadow
            ? <BoxShadow>[
          BoxShadow(
            color: shadowColor ?? AppColors.neutralColors3,
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ]
            : [],
      ),
      child: this,
    );
  }
}