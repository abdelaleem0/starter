import 'package:starter/common/utils/bottom_sheets/show_bottom_sheet_common.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ShowDownloadSketchBottomSheet extends StatelessWidget {
  final String title;
  final VoidCallback onPdfPrimaryButtonTap;
  final VoidCallback onImagePrimaryButtonTap;

  const ShowDownloadSketchBottomSheet(
      {super.key,
      required this.title,
      required this.onPdfPrimaryButtonTap,
      required this.onImagePrimaryButtonTap});

  static show({
    required title,
    required onPdfPrimaryButtonTap,
    required onImagePrimaryButtonTap,
    required context,
  }) async {
    return await appBottomSheetCommon(
      context,
      builder: (context) {
        return ShowDownloadSketchBottomSheet(
          title: title,
          onPdfPrimaryButtonTap: onPdfPrimaryButtonTap,
          onImagePrimaryButtonTap: onImagePrimaryButtonTap,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Text(
            title,
            style: TextStyles.bold(
                color: AppColors.neutral_700, fontSize: Dimensions.xLarge),
          ),
        ),
        _customTitle(
          icon: Iconsax.gallery,
          title:"image",
          onTap: () {
            Navigator.pop(context);
            onImagePrimaryButtonTap();
          },
        ),
        const SizedBox(
          height: PaddingDimensions.large,
        ),
        _customTitle(
          icon: Iconsax.document_download,
          title: "pdf",
          onTap: () {
            Navigator.pop(context);
            onPdfPrimaryButtonTap();
          },
        ),
        const SizedBox(
          height: PaddingDimensions.large,
        ),
      ],
    );
  }

  Widget _customTitle({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(PaddingDimensions.normal),
            decoration: BoxDecoration(
                color: AppColors.primaryColorsSolid4Default.withOpacity(.15),
                borderRadius: BorderRadius.circular(99)),
            child: Icon(
              size: 20,
              icon,
              color: AppColors.primaryColorsSolid4Default,
            ),
          ),
          const SizedBox(width: PaddingDimensions.normal),
          Text(
            title,
            style: TextStyles.medium(
              color: AppColors.neutralColors7,
              fontSize: Dimensions.xLarge,
            ),
          )
        ],
      ),
    );
  }
}
