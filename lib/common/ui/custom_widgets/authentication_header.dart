import 'package:starter/common/blocs/app_language/app_language_bloc.dart';
import 'package:starter/common/ui/custom_widgets/app_icons/app_icon.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/assets_paths/svg_paths.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:math' as math;

class AuthenticationHeader extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final bool useCloseButton;
  final Color tintColor;
  final Color? backgroundColor;

  const AuthenticationHeader(
      {super.key,
      this.onBackPressed,
      this.useCloseButton = false,
      this.tintColor = AppColors.primaryColorsSolid4Default,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? AppColors.neutralColors1,
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: PaddingDimensions.x4Large,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Transform.rotate(
                angle: BlocProvider.of<AppLanguageBloc>(context)
                            .state
                            .locale
                            .languageCode ==
                        "ar"
                    ? math.pi
                    : 0,
                child: InkWell(
                  child: Icon(
                    Iconsax.arrow_left,
                    color: useCloseButton ? tintColor : Colors.transparent,
                  ),
                  onTap: () {
                    if (useCloseButton) {
                      if (onBackPressed != null) {
                        onBackPressed!();
                      } else {
                        _onBackPressed(context);
                      }
                    }
                  },
                ),
              ),
              const Align(
                alignment: AlignmentDirectional.topCenter,
                child: AppIcons(
                  imagePath: SvgPaths.AppLogo,
                ),
              ),
              InkWell(
                child: const Icon(
                  Iconsax.arrow_left,
                  color: Colors.transparent,
                ),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  static void _onBackPressed(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
