import 'package:starter/common/ui/custom_widgets/app_buttons/app_buttons.dart';
import 'package:starter/common/ui/custom_widgets/sketch/sketch_bottom_sheets.dart';
import 'package:starter/common/ui/download_view/download_view_cubit.dart';
import 'package:starter/common/ui/download_view/download_view_state.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/common.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/localization/common_localizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class DownloadWidget extends StatelessWidget {
  final String sketchPdfIdentifier;
  final String sketchImageIdentifier;
  final String sketchId;

  const DownloadWidget({
    super.key,
    required this.sketchPdfIdentifier,
    required this.sketchImageIdentifier,
    required this.sketchId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DownloadViewCubit(),
      child: _DownloadWidgetBody(
          sketchId: sketchId,
          sketchPdfIdentifier: sketchPdfIdentifier,
          sketchImageIdentifier: sketchImageIdentifier),
    );
  }
}

class _DownloadWidgetBody extends StatelessWidget {
  final String sketchPdfIdentifier;
  final String sketchImageIdentifier;
  final String sketchId;

  const _DownloadWidgetBody({
    required this.sketchId,
    required this.sketchPdfIdentifier,
    required this.sketchImageIdentifier,
  });

  void _onDownloadStateIsSuccessOrIsFailure({
    required String text,
    required BuildContext context,
    required bool isSuccess
  }) {
    if(isSuccess){
      showTopSnackSuccess(text: text, context: context);
    }else{
      showTopSnackError(text: text, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DownloadViewCubit, DownloadViewState>(
      listener: (context, state) {
        if (state.downloadState.isSuccess) {
          return _onDownloadStateIsSuccessOrIsFailure(
            text: CommonLocalizer.downloadedSuccessfully,
            context: context,
            isSuccess: true
          );
        }
        if (state.downloadState.isFailure) {
          return _onDownloadStateIsSuccessOrIsFailure(
            text: state.downloadState.errorMessage ?? "",
            context: context,
            isSuccess: false
          );
        }
      },
      child: AppButton.primaryButton(
        buttonHeight: 32,
        horizontalPadding: PaddingDimensions.normal,
        backgroundColor: AppColors.primaryColorsSolid7,
        title: CommonLocalizer.downloadText,
        fontSize: Dimensions.large,
        textColor: AppColors.primaryColorsSolid4Default,
        iconBeforeText: true,
        prefixIcon: const Icon(
          size: IconDimensions.normal,
          Iconsax.receive_square,
          color: AppColors.primaryColorsSolid4Default,
        ),
        onPressed: () {
          ContentActionBottomSheets.showDownloadBottomSheet(
            context: context,
            sketchPdfIdentifier: sketchPdfIdentifier,
            sketchImageIdentifier: sketchImageIdentifier,
            sketchId: sketchId);
        },
      ),
    );
  }
}
