import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';

class HalfsProgressIndicatorWidget extends StatefulWidget {
  final int pageNumber;

  final int numberOfIndicators;

  const HalfsProgressIndicatorWidget(
      {super.key, required this.pageNumber, required this.numberOfIndicators});

  @override
  State<HalfsProgressIndicatorWidget> createState() =>
      _HalfsProgressIndicatorState();
}

class _HalfsProgressIndicatorState extends State<HalfsProgressIndicatorWidget> {
  List<bool> isAnswer = [];

  void numberOfProgressBar() {
    for (int i = 0; i < widget.numberOfIndicators; i++) {
      isAnswer.add(false);
    }
  }

  @override
  void initState() {
    numberOfProgressBar();
    if (widget.pageNumber < isAnswer.length + 1) {
      for (int i = 0; i < widget.pageNumber; i++) {
        isAnswer[i] = true;
      }
    } else {
      isAnswer = isAnswer.map((e) => e = true).toList();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          right: PaddingDimensions.large,left: PaddingDimensions.large),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: isAnswer.map((e) {
          return e == true
              ? Expanded(
            child: Padding(
              padding: const EdgeInsets.all(PaddingDimensions.small),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                height: 4,
              ),
            ),
          )
              : Expanded(
            child: Padding(
              padding: const EdgeInsets.all(PaddingDimensions.small),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.weeklyPlanerProgress.withOpacity(.3),
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                height: 4,
                width: MediaQuery.of(context).size.width/9,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
