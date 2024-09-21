import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:flutter/material.dart';

class ShimmerLoadingEffect extends StatefulWidget{
  final Widget child;
  final Color shimmerColor;
  ShimmerLoadingEffect({Key? key, required this.child, this.shimmerColor = AppColors.neutral_50}) : super(key: key ?? UniqueKey());

  @override
  State<ShimmerLoadingEffect> createState() => _ShimmerLoadingEffectState();
}

class _ShimmerLoadingEffectState extends State<ShimmerLoadingEffect> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<Color?> colorTween;
  late final Animation<Color?> colorTweenReverse;

  @override
  void initState() {
    animationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 1800));
    colorTween = ColorTween(begin: Colors.white, end:  widget.shimmerColor).animate(animationController);
    colorTweenReverse = ColorTween(begin: widget.shimmerColor, end: Colors.white).animate(animationController);


    animationController.forward();


    animationController.addListener(() {

        if(animationController.isCompleted){
          animationController.reverse();
        }else if(animationController.isDismissed){
          animationController.forward();
        }

    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) {
                return LinearGradient(
                    colors: [colorTween.value!,colorTweenReverse.value!]
                ).createShader(bounds);
              },

              child: child,
            );
          },
          child: widget.child

      ),
    );
  }
}