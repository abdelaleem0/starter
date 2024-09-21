import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';

class UserNameSuggestionWidget extends StatefulWidget {
  final List<String> suggestedUserNames;
  final Function(String? userName) selectedSuggestionUserName;
  final String? selectedUserName;

  const UserNameSuggestionWidget(
      {super.key,
        required this.suggestedUserNames,
        required this.selectedSuggestionUserName,
        required this.selectedUserName});

  @override
  State<UserNameSuggestionWidget> createState() =>
      _UserNameSuggestionWidgetState();
}

class _UserNameSuggestionWidgetState extends State<UserNameSuggestionWidget> {
  String? selectedUserName;

  @override
  void didUpdateWidget(covariant UserNameSuggestionWidget oldWidget) {
    selectedUserName = widget.selectedUserName;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.start,
        verticalDirection: VerticalDirection.down,
        children: List.generate(widget.suggestedUserNames.length, (index) {
          return GestureDetector(
            onTap: () {
              selectedUserName = widget.suggestedUserNames[index];
              setState(() {
                widget.selectedSuggestionUserName(selectedUserName);
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: selectedUserName == widget.suggestedUserNames[index]
                    ? AppColors.primaryColorsSolid7
                    : AppColors.neutral_0,
                borderRadius:
                const BorderRadiusDirectional.all(Radius.circular(20)),
                border: selectedUserName == widget.suggestedUserNames[index]
                    ? null
                    : Border.all(color: AppColors.primary_500),
              ),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: PaddingDimensions.normal, horizontal: PaddingDimensions.normal),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(widget.suggestedUserNames[index],
                        style: TextStyles.regular(
                          color: AppColors.primary_400,
                          fontSize: Dimensions.xLarge,
                        )),
                    selectedUserName ==
                        widget.suggestedUserNames[index] ? InkWell(
                        onTap: () {
                          setState(() {
                            selectedUserName = null;
                            widget.selectedSuggestionUserName(null);
                          });
                        },
                        child: const Icon(
                          Icons.close_rounded,
                          size: 14,
                          color: AppColors.primary_400,
                        )) : const SizedBox()
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
