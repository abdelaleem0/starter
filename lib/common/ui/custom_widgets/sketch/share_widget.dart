import 'package:starter/common/ui/custom_widgets/app_buttons/app_buttons.dart';
import 'package:starter/common/ui/custom_widgets/sketch/sketch_bottom_sheets.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/localization/common_localizer.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ShareWidget extends StatelessWidget {
  final String sketchId;
  final String sketchPdfIdentifier;
  final String sketchImageIdentifier;

  const ShareWidget({
    super.key,
    required this.sketchId,
    required this.sketchPdfIdentifier,
    required this.sketchImageIdentifier,
  });

  @override
  Widget build(BuildContext context) {
    return _buildShareBtn(context);
  }

  Widget _buildShareBtn(BuildContext context) {
    return AppButton.primaryButton(
        buttonHeight: 32,
        backgroundColor: AppColors.primaryColorsSolid7,
        textColor: AppColors.primaryColorsSolid4Default,
        title: CommonLocalizer.shareText,
        fontSize: Dimensions.large,
        horizontalPadding: PaddingDimensions.normal,
        prefixIcon: const Icon(
          size: IconDimensions.normal,
          Iconsax.share,
          color: AppColors.primaryColorsSolid4Default,
        ),
        onPressed: () {
          ContentActionBottomSheets.showShareBottomSheet(
              context: context,
              sketchId: sketchId,
              sketchPdfIdentifier: sketchPdfIdentifier,
              sketchImageIdentifier: sketchImageIdentifier);
        });
  }
}
