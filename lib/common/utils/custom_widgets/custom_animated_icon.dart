import 'package:flutter/material.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';

// ignore: must_be_immutable
class CustomAnimatedTransitionIcon extends StatelessWidget {
  CustomAnimatedTransitionIcon(
      {super.key,
      required this.onPressFun,
      required this.firstIcon,
      required this.secondIcon,
      this.toggle = false,
      this.scaleNotFadeTransition = false,
      this.iconColor,
      this.animatedDuration = 300});
  final VoidCallback onPressFun;
  final IconData firstIcon;
  final IconData secondIcon;
  final Color? iconColor;
  bool scaleNotFadeTransition = false;
  bool toggle = false;
  int animatedDuration = 300;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: AnimatedSwitcher(
          duration: Duration(milliseconds: animatedDuration),
          transitionBuilder: (child, anim) => RotationTransition(
                turns: child.key == const ValueKey('icon1')
                    ? Tween<double>(begin: 1, end: 0.75).animate(anim)
                    : Tween<double>(begin: 0.75, end: 1).animate(anim),
                child: scaleNotFadeTransition
                    ? FadeTransition(opacity: anim, child: child)
                    : ScaleTransition(scale: anim, child: child),
              ),
          child: toggle
              ? Icon(
                  firstIcon,
                  key: const ValueKey('icon1'),
                  color: iconColor ?? AppColors.textSecondaryColor,
                )
              : Icon(
                  secondIcon,
                  key: const ValueKey('icon2'),
                  color: iconColor ?? AppColors.textSecondaryColor,
                )),
      onPressed: () => onPressFun(),
    );
  }
}
