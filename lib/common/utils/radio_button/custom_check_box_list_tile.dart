import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:flutter/material.dart';

class CustomCheckboxListTile extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String title;

  const CustomCheckboxListTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            style: TextStyles.medium(color: AppColors.neutral_700),
          )),
          Theme(
            data: Theme.of(context)
                .copyWith(unselectedWidgetColor: AppColors.defaultGray),
            child: Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              value: value,
              onChanged: onChanged,
              checkColor: Colors.white,
              activeColor: AppColors.primaryColorsSolid4Default,
            ),
          ),
        ],
      ),
    );
  }
}
