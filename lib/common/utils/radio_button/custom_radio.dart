import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:flutter/material.dart';

class CustomRadio<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final Color activeColor;
  final Color? selectedColor;

  const CustomRadio(
      {super.key,
      required this.value,
      required this.groupValue,
      this.onChanged,
       this.selectedColor,
      this.activeColor = AppColors.secondaryColorsSolidPurple4Default});

  @override
  Widget build(BuildContext context) {
    return Radio(
        activeColor: activeColor,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
        fillColor: WidgetStateProperty.all(selectedColor),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged);
  }
}
