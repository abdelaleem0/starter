import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'bottom_sheet_menu_model.dart';

class MenuBottomSheet extends StatelessWidget {
  final List<MenuBottomSheetModel> menuModels;
  final List<MenuBottomSheetModel>? actionButtons;
  final bool isShowDivider;

  const MenuBottomSheet({
    required this.menuModels,
    super.key,
    this.actionButtons,
    this.isShowDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(actionButtons!.length, (index) {
              return _Tile(model: actionButtons![index]);
            }),
          ),
        ),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  final MenuBottomSheetModel model;
  const _Tile({required this.model,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(model.onTap != null){
          model.onTap!(context);
        }
      },
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          bottom: PaddingDimensions.large,
        ),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: AppColors.primaryColorsSolid7,
                  shape: BoxShape.circle
              ),
              padding: const EdgeInsets.all(PaddingDimensions.medium-2),
              child: Icon(
                size: IconDimensions.normal,
                model.iconData,
                color: AppColors.primaryColorsSolid4Default,
              ),
            ),
            const SizedBox(width: PaddingDimensions.large,),

            Text(model.title,style: TextStyles.medium(fontSize: Dimensions.xLarge,color: AppColors.neutralColors7),)
          ],
        ),
      ),
    );
  }
}

