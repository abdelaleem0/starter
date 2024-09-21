import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';

class DottedBorderView extends StatelessWidget {
  final IconData icon;
  final String? title;
  final VoidCallback onTap;
  final double? height;
  final double? width;

  const DottedBorderView(
      {super.key,
      required this.icon,
      this.title,
      required this.onTap,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: const [8, 7],
      color: AppColors.neutralColors3,
      borderType: BorderType.RRect,
      radius: const Radius.circular(Dimensions.regularRadius),
      child: SizedBox(
          height: height ?? 100,
          width: width ?? double.infinity,
          child: GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.translucent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: IconDimensions.large,
                  color: AppColors.neutralColors6,
                ),
                if (title != null) ...[
                  const SizedBox(
                    height: PaddingDimensions.medium - 2,
                  ),
                  Text(
                    title ?? '',
                    style: TextStyles.regular(
                        color: AppColors.neutralColors5,
                        fontSize: Dimensions.xLarge),
                  ),
                ]
              ],
            ),
          )),
    );
  }
}
