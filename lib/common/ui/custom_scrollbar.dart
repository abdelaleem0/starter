import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:starter/common/blocs/app_language/app_language_bloc.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomScrollbarWidget extends StatelessWidget {
  final Widget child;
  final ScrollController scrollController;
  final bool? isHome;
  final Color? scrollbarColor;
  final bool? withoutPadding;
  final Gradient? scrollbarGradientColor;
  final double? width;
  const CustomScrollbarWidget(
      {super.key,
      required this.child,
      required this.scrollController,
      this.isHome,
      this.scrollbarColor,
      this.withoutPadding,
      this.scrollbarGradientColor,
      this.width,
      });

  @override
  Widget build(BuildContext context) {
    final lang =
        BlocProvider.of<AppLanguageBloc>(context).state.locale.languageCode;
    return Padding(
      padding:(withoutPadding==true) ?EdgeInsets.zero:  const EdgeInsets.symmetric(
          vertical: PaddingDimensions.xLarge,
          ),
      child: AdaptiveScrollbar(
        position:
            lang == "ar" ? ScrollbarPosition.left : ScrollbarPosition.right,
        controller: scrollController,
        underSpacing:
        (withoutPadding==true) ? EdgeInsets.zero:  const EdgeInsets.symmetric(horizontal: PaddingDimensions.small),
        sliderSpacing: const EdgeInsets.all(0.0),
        width: width ??6,
        underDecoration: const BoxDecoration(
            color: AppColors.neutral_50,
            borderRadius:
                BorderRadius.all(Radius.circular(PaddingDimensions.normal))),
        sliderDecoration: BoxDecoration(
          gradient: isHome == null
              ? null
              : scrollbarGradientColor??const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: AppColors.gradient_3),
          // color: Colors.white,
          color: scrollbarColor ?? AppColors.primaryColorsSolid4Default,
          borderRadius: const BorderRadius.all(
            Radius.circular(PaddingDimensions.normal),
          ),
        ),
        child: child,
      ),
    );
  }
}
