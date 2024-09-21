import 'package:starter/common/blocs/app_language/app_language_bloc.dart';
import 'package:starter/common/ui/custom_widgets/sketch/sketch_app_bar.dart';
import 'package:starter/common/ui/custom_widgets/app_buttons/app_buttons.dart';
import 'package:starter/common/ui/custom_widgets/app_icons/app_icon.dart';
import 'package:starter/common/ui/custom_widgets/sketch/sketch_bottom_sheets.dart';
import 'package:starter/common/ui/custom_widgets/sketch/sketch_utility_widget.dart';
import 'package:starter/common/ui/download_view/download_view_cubit.dart';
import 'package:starter/common/utils/app_routes/router_functions.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/assets_paths/svg_paths.dart';
import 'package:starter/common/utils/date_time_format.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/localization/common_localizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class SketchPage extends StatefulWidget {
  static String routeName = 'SketchPage';
  final int startDate;
  final int? endDate;
  final String sketchTitle;
  final String sketchId;
  final Widget sketchBody;
  final VoidCallback onCompleted;
  final String sketchPdfIdentifier;
  final String sketchImageIdentifier;
  final VoidCallback? onBackPressed;
  final bool isFromHome;

  const SketchPage(
      {super.key,
      required this.startDate,
      this.endDate,
      required this.sketchTitle,
      required this.sketchId,
      required this.sketchBody,
      required this.onCompleted,
      required this.sketchPdfIdentifier,
      this.onBackPressed,
      required this.sketchImageIdentifier,this.isFromHome=false});

  @override
  State<SketchPage> createState() => _SketchPageState();
}

class _SketchPageState extends State<SketchPage> {
  ScrollController scrollController = ScrollController();

  bool isVisible = false;

  @override
  void initState() {
    scrollController.addListener(handlingFilterBarVisibility);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang =
        BlocProvider.of<AppLanguageBloc>(context).state.locale.languageCode;

    return BlocProvider(
      create: (context) => DownloadViewCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: DefaultSketchAppBar.sketchAppBar(
              isFromHome: widget.isFromHome,
              actions: isVisible
                  ? [
                      GestureDetector(
                        onTap: () {
                          ContentActionBottomSheets.showDownloadBottomSheet(
                              context: context,
                              sketchId: widget.sketchId,
                              sketchPdfIdentifier: widget.sketchPdfIdentifier,
                              sketchImageIdentifier:
                                  widget.sketchImageIdentifier);
                        },
                        child: const Icon(
                          Iconsax.receive_square,
                        ),
                      ),
                      const SizedBox(
                        width: PaddingDimensions.large,
                      ),
                      GestureDetector(
                        onTap: () {
                          ContentActionBottomSheets.showShareBottomSheet(
                              context: context,
                              sketchId: widget.sketchId,
                              sketchPdfIdentifier: widget.sketchPdfIdentifier,
                              sketchImageIdentifier:
                                  widget.sketchImageIdentifier);
                        },
                        child: const Icon(
                          Iconsax.share,
                        ),
                      ),
                    ]
                  : [], onBackPressed: () {
            if (widget.onBackPressed != null) {
              widget.onBackPressed!();
            } else {
              AppRouteNavigator.popUntil(context);
            }
          }, context,
              title: '', startDate: widget.startDate, endDate: widget.endDate),
          backgroundColor: Colors.transparent,
          body: _SketchBody(
            scrollController: scrollController,
            onCompleted: widget.onCompleted,
            isHome: false,
            lang: lang,
            title: widget.sketchTitle.trim(),
            id: widget.sketchId,
            startDate: widget.startDate,
            endDate: widget.endDate,
            questionWidget: widget.sketchBody,
            sketchPdfIdentifier: widget.sketchPdfIdentifier,
            sketchImageIdentifier: widget.sketchImageIdentifier,
            isFromHome: widget.isFromHome,
          ),
        );
      }),
    );
  }

  void handlingFilterBarVisibility() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (scrollController.offset > MediaQuery.sizeOf(context).height * 0.21) {
        if (!isVisible) {
          isVisible = true;
          setState(() {});
        }
      }
    } else {
      if (scrollController.offset <= MediaQuery.sizeOf(context).height * 0.21) {
        if (isVisible) {
          isVisible = false;
          setState(() {});
        }
      }
    }
  }
}

class _SketchBody extends StatelessWidget {
  final String lang;
  final bool isHome;
  final String title;
  final Widget questionWidget;
  final String id;
  final int startDate;
  final int? endDate;
  final VoidCallback? onCompleted;
  final String sketchPdfIdentifier;
  final String sketchImageIdentifier;
  final ScrollController scrollController;
  final bool isFromHome;

  const _SketchBody({
    required this.lang,
    required this.isHome,
    required this.title,
    required this.questionWidget,
    required this.id,
    required this.startDate,
    this.endDate,
    this.onCompleted,
    required this.sketchPdfIdentifier,
    required this.sketchImageIdentifier,
    required this.scrollController,
    required this.isFromHome,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.neutralColors1,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                margin: const EdgeInsets.only(
                  top: PaddingDimensions.xxLarge,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: PaddingDimensions.x4Large,
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Center(
                              child: AppIcons(
                                height: IconDimensions.xLarge,
                                width: IconDimensions.xLarge,
                                imagePath: SvgPaths.ajmalLogo,
                                color: AppColors.neutralColors7,
                              ),
                            ),
                            const SizedBox(
                              height: Dimensions.large,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: PaddingDimensions.normal),
                              child: Text(
                                title,
                                style: TextStyles.semiBold(
                                  color: AppColors.neutralColors7,
                                  fontSize: Dimensions.xxxxLarge,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: Dimensions.normal,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  convertTimeStampWithNameStartByMonth(
                                      timeStamp: startDate, lang: lang),
                                  style: TextStyles.regular(
                                    color: AppColors.neutralColors7,
                                    fontSize: Dimensions.xLarge,
                                  ),
                                ),
                                if (endDate != null) ...[
                                  Text(
                                    " to ",
                                    style: TextStyles.regular(
                                      color: AppColors.neutralColors7,
                                      fontSize: Dimensions.xLarge,
                                    ),
                                  ),
                                  Text(
                                    convertTimeStampWithNameStartByMonth(
                                      timeStamp: endDate ?? 0,
                                      lang: lang,
                                    ),
                                    style: TextStyles.regular(
                                      color: AppColors.neutralColors7,
                                      fontSize: Dimensions.xLarge,
                                    ),
                                  ),
                                ]
                              ],
                            ),
                            const SizedBox(
                              height: PaddingDimensions.large,
                            ),
                          ],
                        ),
                        SketchUtilityWidget(
                          isHome: isHome,
                          id: id,
                          sketchPdfIdentifier: sketchPdfIdentifier,
                          sketchImageIdentifier: sketchImageIdentifier,
                        ),
                        // const SizedBox(
                        //   height: PaddingDimensions.xxLarge,
                        // ),
                        questionWidget,
                         SizedBox(
                          height:isFromHome? PaddingDimensions.normal:PaddingDimensions.x7Large,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if(!isFromHome)
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: PaddingDimensions.large,
                      vertical: PaddingDimensions.xxxLarge),
                  child: AppButton.primaryButton(
                    isExpanded: true,
                    title: CommonLocalizer.complete,
                    onPressed: () {
                      if (onCompleted != null) {
                        onCompleted!();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
