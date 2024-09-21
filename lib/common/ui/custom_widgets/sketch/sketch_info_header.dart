import 'package:starter/common/blocs/app_language/app_language_bloc.dart';
import 'package:starter/common/utils/ajmal/default_back_button.dart';
import 'package:starter/common/utils/app_routes/router_functions.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/date_time_format.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SketchInfoHeader extends StatefulWidget {
  final DateTime createdAt;
  final bool isHome;
  final String? titleHeader;
  final String? title;

  const SketchInfoHeader(
      {super.key,
      required this.createdAt,
      required this.isHome,
      this.titleHeader,
      this.title});

  @override
  State<SketchInfoHeader> createState() => _SketchInfoHeaderState();
}

class _SketchInfoHeaderState extends State<SketchInfoHeader> {
  late String lang;

  @override
  void initState() {
    lang = BlocProvider.of<AppLanguageBloc>(context).state.locale.languageCode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.isHome) ...[
          DefaultBackButton(
            onPressed: () {
              AppRouteNavigator.popUntil(context);
            },
          ),
        ],
        const SizedBox(width: PaddingDimensions.normal),
        Image.asset(
          "images/common/ajmal_logo.png",
          scale: 4.5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: PaddingDimensions.large),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.title != null
                  ? Text(widget.title!,
                      style: TextStyles.semiBold(
                        color: AppColors.neutral_0,
                        fontSize: Dimensions.large,
                      ),
                      textAlign: TextAlign.center)
                  : const SizedBox(),
              widget.titleHeader != null
                  ?Text(widget.titleHeader??'',style: TextStyles.regular(fontSize: Dimensions.xLarge,color: AppColors.neutral_0))
                  : const SizedBox(),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                      '${convertTimeStampWithNameStartByMonth(timeStamp: widget.createdAt.millisecondsSinceEpoch, lang: lang)} ',
                      style: TextStyles.regular(
                          color: AppColors.neutral_0,
                          fontSize: Dimensions.normal,
                          height: 1.4),
                      textAlign: TextAlign.start),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
