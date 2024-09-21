import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:flutter/material.dart';

class AjmalStackedContainer extends StatelessWidget {
  final Widget body;
  final List<Color>? gradientColors;
  final double? bottomSpace;
  final double? height;

  const AjmalStackedContainer(
      {super.key,
      required this.body,
      this.gradientColors,
      this.bottomSpace,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Container(
            clipBehavior: Clip.hardEdge,
            height: height,
            decoration: const BoxDecoration(
              color: AppColors.neutralColors1,
              borderRadius: BorderRadius.all(
                Radius.circular(24),
              ),
            ),
            child: body,
          ),
        ),
      ],
    );
  }
}
