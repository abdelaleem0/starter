import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:flutter/material.dart';

class AppShader extends StatelessWidget {
  final List<Color>? colors;
  final Widget child;

   const AppShader({super.key, this.colors = const [AppColors.primaryColorsSolid4Default], required this.child});

  @override
  Widget build(BuildContext context) {
    if(colors == null){
      return child;
    }
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: colors ?? [],
        ).createShader(bounds);
      },
      child: child,
    );
  }
}
