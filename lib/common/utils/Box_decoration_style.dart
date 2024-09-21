import 'package:flutter/material.dart';

BoxDecoration boxDecorationStyle(Color color) {
  return BoxDecoration(
    // gradient: LinearGradient(colors: AppColors.gradient_4),
    color: color,
    //AppColors.backgroundMain,
    borderRadius: const BorderRadius.all(
      Radius.circular(24),
    ),
  );
}
