import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/extensions/media_query.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MenuDialogItem extends PopupMenuItem{
  final String text;
  final Color textColor;
  final Function() onPressed;
  MenuDialogItem({
    super.key,
    this.textColor = AppColors.neutralColors7,
    required this.text,
    required this.onPressed,
  }) : super(
    child: Builder(
      builder: (context) {
        return Text(
          text,
          style: TextStyles.medium(
            color: textColor,
            fontSize: (Dimensions.large * ((ResponsiveBreakpoints.of(context).screenWidth)/context.width)).clamp(Dimensions.large, Dimensions.smallDisplay)
          ),
        );
      }
    )
  );

  @override
  double get height => 4;

  @override
  VoidCallback? get onTap => (){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onPressed();
    });
  };

  @override
  EdgeInsets? get padding => const EdgeInsets.symmetric(horizontal: PaddingDimensions.large,vertical: PaddingDimensions.medium);

}