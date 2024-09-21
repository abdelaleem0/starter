import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';

class AjmalStaticPaddingQuestionBody extends StatelessWidget {
  const AjmalStaticPaddingQuestionBody({super.key, required this.children});
final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: PaddingDimensions.xxLarge
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          verticalDirection: VerticalDirection.down,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}
