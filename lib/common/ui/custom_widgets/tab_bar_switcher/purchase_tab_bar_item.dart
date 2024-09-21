import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';


class PurchaseTabItem extends StatelessWidget {
  final String item;
  final bool isSelected;
  final Color? selectedBgColor;
  const PurchaseTabItem({super.key, required this.item, required this.isSelected,  this.selectedBgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: PaddingDimensions.medium,
          horizontal: PaddingDimensions.xxxLarge + 2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.xLargeRadius),
        color: isSelected
            ? selectedBgColor?? AppColors.primaryColorsSolid4Default
            : Colors.transparent,
      ),
      child: Text(
        item,
        style: TextStyles.medium(
            fontSize: Dimensions.xLarge,
            color: isSelected
                ? AppColors.neutralColors1
                : AppColors.neutralColors7
        ),
      ),
    );
  }
}



