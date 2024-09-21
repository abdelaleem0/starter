import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class MenuBottomSheetModel extends Equatable {
  final Function(BuildContext context)? onTap;
  final IconData? iconData;
  final String title;

  const MenuBottomSheetModel( {
    this.onTap,
    this.iconData,
    required this.title,
  });

  MenuBottomSheetModel reduce({
    IconData? iconPath,
    String? title,
    Color? activeColor,
    Function(BuildContext context)? onTap,
  }) {
    return MenuBottomSheetModel(
      onTap: onTap ?? this.onTap,
      iconData: iconPath ?? iconData,
      title: title ?? this.title,
    );
  }

  @override
  List<Object?> get props => [
        iconData,
        title,
        onTap,
      ];
}
