import 'package:flutter/material.dart';
import 'package:starter/common/utils/bottom_sheets/show_bottom_sheet_common.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/common.dart';

import '../dimensions.dart';

void showAppHandelMessageBottomSheet(
  context, {
  String? title,
  String? subTitle,
  bool isSuccess = false,
  bool barrierDismissible = true,
}) async {
  return await appBottomSheetCommon(
    context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: PaddingDimensions.x4Large,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: PaddingDimensions.xxLarge,
            ),
            Row(
              children: [
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.neutralColors3,
                    )),
              ],
            ),
            isSuccess
                ? Image.asset(
                    successIcon,
                    width: 50,
                    height: 50,
                  )
                : Image.asset(
                    errorIcon,
                    width: 50,
                    height: 50,
                  ),
            const SizedBox(
              height: PaddingDimensions.large,
            ),
            title != null
                ? Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyles.bold(
                      color: AppColors.primaryColorsSolid5,
                      fontSize: Dimensions.xLarge,
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              height: PaddingDimensions.large,
            ),
            subTitle != null
                ? Text(
                    subTitle,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyles.medium(
                      color: AppColors.neutralColors5,
                      fontSize: Dimensions.large,
                      height: 1.7,
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              height: PaddingDimensions.x6Large,
            ),
          ],
        ),
      );
    },
  );
}
