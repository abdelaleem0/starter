import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CustomSwitch extends StatelessWidget {
  final Color? activeColor;
  final Color? inActiveColor;
  final Color? inActiveThumbColor;
  final bool value;
  final void Function(bool value) onChanged;
  final Color? thumbColor;
  final double? toggleSize;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.inActiveColor,
    this.inActiveThumbColor,
    this.thumbColor,
    this.toggleSize
  });

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      padding: (value==true? 4 : 6),
      value: value,
      onToggle: onChanged,
      height: 32,
      width: 52,
      activeColor: activeColor ?? AppColors.primaryColorsSolid4Default,
      inactiveColor: inActiveColor ?? AppColors.neutralColors1,
      activeToggleColor: thumbColor??AppColors.neutralColors1,
      inactiveToggleColor: inActiveThumbColor??AppColors.neutralColors5,
      toggleSize: toggleSize?? (value==true? 22 : 15),
      switchBorder: value==true?Border.all(color: AppColors.primaryColorsSolid4Default,):Border.all(color: AppColors.neutralColors5,width: 2),
    );
  }
}
