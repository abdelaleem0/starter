import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';

class StaticPaddingOfMultiAnswersWeeklyPlannerQuestionBody
    extends StatelessWidget {
  const StaticPaddingOfMultiAnswersWeeklyPlannerQuestionBody(
      {super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: PaddingDimensions.small,
          right: PaddingDimensions.small,
          ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
