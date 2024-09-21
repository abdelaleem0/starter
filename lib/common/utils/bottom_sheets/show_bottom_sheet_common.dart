import 'package:starter/common/ui/app_responsive/app_responsive_scaled_box.dart';
import 'package:starter/common/ui/custom_widgets/app_buttons/app_buttons.dart';
import 'package:starter/common/ui/custom_widgets/app_icons/app_icon.dart';
import 'package:starter/common/utils/app_routes/router_functions.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/assets_paths/svg_paths.dart';
import 'package:starter/common/utils/bottom_sheets/menu_bottom_sheet/menu_bottom_sheet.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/media_utils/media_utils.dart';
import 'package:starter/common/utils/media_utils/src/media_picker_utils/media_picker_utils.dart';
import 'package:flutter/material.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:flutter_html/flutter_html.dart';
import '../localization/common_localizer.dart';
import 'media_picker_bottom_sheet/media_picker_bottom_sheet.dart';
import 'menu_bottom_sheet/bottom_sheet_menu_model.dart';

Future<T?> appBottomSheetCommon<T>(BuildContext context,
    {required Widget Function(BuildContext context) builder,
    bool checkBorder = true,
    bool useRootNavigator = true,
    bool addContainerFromStart = true,
    Color? barrierColor,
    Color? backgroundColor,
    AlignmentGeometry? alignedAlignment,
    bool isDismissible = true,
    String? title,
    EdgeInsetsGeometry? padding,
    double? topHeight}) async {
  return showModalBottomSheet<T>(
    isDismissible: isDismissible,
    enableDrag: isDismissible,
    context: context,
    useRootNavigator: useRootNavigator,
    backgroundColor: backgroundColor ?? AppColors.neutralColors1,
    clipBehavior: Clip.antiAlias,
    barrierColor: barrierColor,
    shape: RoundedRectangleBorder(
      borderRadius: checkBorder
          ? const BorderRadius.only(
              topLeft: Radius.circular(Dimensions.xLargeRadius),
              topRight: Radius.circular(Dimensions.xLargeRadius),
            )
          : BorderRadius.circular(0),
    ),
    isScrollControlled: true,
    constraints: const BoxConstraints(
      maxWidth: double.infinity,
      minWidth: double.infinity,
      //if added height constraints test the bottom sheets that have columns or lists because it will lead to unwanted behaviour
    ),
    builder: (context) {
      return AppResponsiveScaledBox(
        useDynamicHeight: true,
        alignment: alignedAlignment,
        child: Builder(builder: (context) {
          return Padding(
              padding: padding ??
                  const EdgeInsetsDirectional.only(
                    bottom: PaddingDimensions.large,
                    top: PaddingDimensions.large,
                    start: PaddingDimensions.large,
                    end: PaddingDimensions.large,
                  ),
              child: Column(
                children: [
                  if (addContainerFromStart)
                    Center(
                      child: Container(
                        width: 32,
                        height: PaddingDimensions.small,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColors.neutralColors4,
                          borderRadius: BorderRadius.all(
                            Radius.circular(PaddingDimensions.small),
                          ),
                        ),
                      ),
                    ),
                  if (title != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: PaddingDimensions.large,
                        bottom: PaddingDimensions.large,
                      ),
                      child: Text(
                        title,
                        style:
                            TextStyles.semiBold(fontSize: Dimensions.xxxxLarge),
                      ),
                    )
                  else
                    SizedBox(
                      height: topHeight ?? PaddingDimensions.xLarge,
                    ),
                  builder(context),
                ],
              ));
        }),
      );
    },
  );
}

Future<T?> appBottomSheetConfirmOrBack<T>({
  required BuildContext context,
  required String title,
  String? description,
  bool? isHTMLDescription,
  required VoidCallback onConfirmClick,
  VoidCallback? onCancelClick,
  String? confirmButtonText,
  String? cancelText,
  bool? isLoading,
  bool isDismissible = true,
}) {
  return appBottomSheetCommon(
    isDismissible: isDismissible,
    context,
    builder: (context) {
      return Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyles.semiBold(
                      color: AppColors.neutralColors7,
                      fontSize: Dimensions.xxxxLarge,
                    ),
                  ),
                  const SizedBox(height: PaddingDimensions.normal),
                  if (description != null) ...[
                    (isHTMLDescription==true)
                        ? Html(data: description)
                        : Text(
                            textAlign: TextAlign.center,
                            description,
                            style: TextStyles.regular(
                              color: AppColors.neutralColors7,
                              fontSize: Dimensions.xLarge,
                            ),
                          ),
                    const SizedBox(height: PaddingDimensions.x6Large),
                    const SizedBox(
                      height: PaddingDimensions.x4Large,
                    ),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.xxLarge),
              child: Row(
                children: [
                  Expanded(
                      child: AppButton.outlinedButton(
                    buttonHeight: Dimensions.buttonMediumHeight,
                    borderColor: AppColors.primaryColorsSolid4Default,
                    title: cancelText ?? CommonLocalizer.back,
                    horizontalPadding: 0,
                    isExpanded: true,
                    color: AppColors.backgroundTransparentColor,
                    textColor: AppColors.primaryColorsSolid4Default,
                    onPressed: onCancelClick ??
                        () {
                          AppRouteNavigator.pop(context);
                        },
                  )),
                  const SizedBox(width: PaddingDimensions.small),
                  Expanded(
                      child: AppButton.primaryButton(
                    isLoading: isLoading ?? false,
                    buttonHeight: Dimensions.buttonMediumHeight,
                    title: confirmButtonText ?? CommonLocalizer.yes,
                    isExpanded: true,
                    horizontalPadding: 0,
                    color: AppColors.primaryColorsSolid4Default,
                    textColor: AppColors.neutralColors1,
                    onPressed: () {
                      onConfirmClick();
                    },
                  ))
                ],
              ),
            ),
            const SizedBox(
              height: PaddingDimensions.xxLarge,
            )
          ],
        ),
      );
    },
  );
}

void socialAccountBottomSheet({
  required BuildContext context,
  required String title,
  required String description,
  required VoidCallback onConfirmClick,
  String? confirmButtonText,
  String? cancelText,
  bool? isLoading,
  String? socialAccountImage,
}) {
  appBottomSheetCommon(context, builder: (context) {
    return SizedBox(
        width: double.infinity,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(
            height: PaddingDimensions.medium,
          ),
          AppIcons(
            imagePath: socialAccountImage ?? SvgPaths.google,
            height: 56,
            width: 56,
          ),
          const SizedBox(
            height: PaddingDimensions.xLarge,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyles.semiBold(
              color: AppColors.neutralColors7,
              fontSize: Dimensions.xxxxLarge,
            ),
          ),
          const SizedBox(height: PaddingDimensions.normal),
          Text(
            textAlign: TextAlign.center,
            description,
            style: TextStyles.regular(
              color: AppColors.neutralColors7,
              fontSize: Dimensions.xLarge,
            ),
          ),
          const SizedBox(
            height: PaddingDimensions.x4Large,
          ),
          AppButton.primaryButton(
              buttonHeight: Dimensions.buttonHeight,
              onPressed: onConfirmClick,
              isExpanded: true,
              title: confirmButtonText ?? CommonLocalizer.ok),
          const SizedBox(
            height: PaddingDimensions.large,
          ),
          AppButton.outlinedButton(
              buttonHeight: Dimensions.buttonHeight,
              isExpanded: true,
              onPressed: () {
                AppRouteNavigator.pop(context);
              },
              title: cancelText ?? CommonLocalizer.cancel),
          const SizedBox(
            height: PaddingDimensions.xxLarge,
          )
        ]));
  });
}



Future<void> showMenuBottomSheet(
  BuildContext context, {
  required List<MenuBottomSheetModel> menuModels,
  final List<MenuBottomSheetModel>? actionButtonsModels,
  bool isShowDivider = false,
}) async {
  await appBottomSheetCommon(
    context,
    builder: (context) {
      return MenuBottomSheet(
        isShowDivider: isShowDivider,
        menuModels: menuModels,
        actionButtons: actionButtonsModels,
      );
    },
  );
}

Future<T?> showMediaPickerUtilsBottomSheet<T>({
  required BuildContext pageContext,
  PickedMediaCallback? onPickMedia,
  PickedMultipleMediaCallback? onPickMultiMedia,
  required List<MediaPickType> types,
  PickerVideoProperties? pickerVideoProperties,
  bool canModifyImage = false,
  Function()? onLoading,
  final bool? isRemovable,
  final VoidCallback? onRemove,
}) async {
  return await appBottomSheetCommon<T?>(
    pageContext,
    builder: (_) {
      return MediaPickerBottomSheet(
        isRemovable: isRemovable,
        onRemove: onRemove,
        pageContext: pageContext,
        onPickMedia: onPickMedia,
        onPickMultiMedia: onPickMultiMedia,
        canModifyImage: canModifyImage,
        types: types,
        pickerVideoProperties: pickerVideoProperties,
        onLoading: onLoading,
      );
    },
  );
}
