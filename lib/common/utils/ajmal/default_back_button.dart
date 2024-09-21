import 'package:starter/common/blocs/app_language/app_language_bloc.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class DefaultBackButton extends StatelessWidget {
  final void Function() onPressed;
  final Color? backgroundColor;

  const DefaultBackButton({super.key, required this.onPressed, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    var lang =
        BlocProvider.of<AppLanguageBloc>(context).state.locale.languageCode;
    return GestureDetector(
      onTap:
        onPressed
      ,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(
              lang == "en" ? Iconsax.arrow_left_24 : Iconsax.arrow_right_1,
              color: AppColors.neutral_0,
              size: MediaQuery.of(context).size.aspectRatio*50),
        ),
      ),
    );
  }
}
class ClearButton extends StatelessWidget {
  final void Function() onPressed;
  final Color? backgroundColor;

  const ClearButton({super.key, required this.onPressed, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.only(
          // top: 10,
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor ?? AppColors.backgroundTransparentColor,
              borderRadius: const BorderRadiusDirectional.all(Radius.circular(32)),
            ),
            child:  Padding(
              padding: const EdgeInsets.all(PaddingDimensions.medium),
              child: Icon(
                   Icons.close ,
                  color: backgroundColor?? AppColors.neutral_0,
                  size: 22),
            ),
          ),
        ),
      ),
    );
  }
}
