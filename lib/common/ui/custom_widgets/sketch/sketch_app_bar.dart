import 'package:starter/common/domain/use_cases/open_calendar_use_case.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/custom_widgets/application_app_bars.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/di/app_injector.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DefaultSketchAppBar {
  DefaultSketchAppBar._();

  static PreferredSizeWidget sketchAppBar(
    BuildContext context, {
    required String title,
    required int startDate,
    required int? endDate,
        VoidCallback? onBackPressed,
        List<Widget>? actions,
        bool isFromHome=false,

      }) {
    return ApplicationAppBars.defaultAppBar(
      context: context,
      backgroundColor: Colors.transparent,
      useCloseButton: true,
      tintColor: AppColors.neutralColors1,
      actions: [
        if(actions != null)
          ...[
        ...actions,
        const SizedBox(
          width: PaddingDimensions.large,
        ),
        ],
        if(!isFromHome)
        ...[InkWell(
          onTap: () {
            injector<OpenCalendarUseCase>().call();
          },
          child: const Icon(
            Iconsax.calendar_add,
            color: AppColors.neutralColors1,
          ),
        ),
        const SizedBox(
          width: PaddingDimensions.large,
        ),]
      ],
        onBackPressed :onBackPressed,
    );
  }
}
