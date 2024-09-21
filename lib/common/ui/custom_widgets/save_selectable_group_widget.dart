// import 'package:starter/app/feel_well/domain/models/positive_models/action_entity.dart';
// import 'package:starter/common/utils/app_style/app_colors.dart';
// import 'package:starter/common/utils/app_style/text_styles.dart';
// import 'package:starter/common/utils/dimensions.dart';
// import 'package:flutter/material.dart';
//
// class SaveSelectableGroupWidget extends StatefulWidget {
//   final List<ActionEntity> strengths;
//   final Function(List<ActionEntity> actions) onActionsSelected;
//   final List<ActionEntity>? selectedActions;
//
//   const SaveSelectableGroupWidget(
//       {super.key,
//       required this.strengths,
//       required this.onActionsSelected,
//       this.selectedActions
//       });
//
//   @override
//   State<SaveSelectableGroupWidget> createState() =>
//       _SaveSelectableGroupWidgetState();
// }
//
// class _SaveSelectableGroupWidgetState extends State<SaveSelectableGroupWidget> {
//   late List<ActionEntity> strengths;
//   List<ActionEntity> selectedActions = [];
//
//   @override
//   void initState() {
//     selectedActions = widget.selectedActions ?? [];
//     strengths = widget.strengths;
//     super.initState();
//   }
//
//   @override
//   void didUpdateWidget(covariant SaveSelectableGroupWidget oldWidget) {
//     if (oldWidget.strengths != widget.strengths) {
//       if (widget.strengths.isNotEmpty) {
//         for (var selectedStrength in selectedActions) {
//           final index = widget.strengths.indexWhere((element) =>
//               element.text?.toLowerCase() ==
//               selectedStrength.text?.toLowerCase());
//           if (index != -1) {
//             widget.strengths[index] =
//                 widget.strengths[index].modify(isSelected: true);
//           }
//         }
//       }
//     }
//     super.didUpdateWidget(oldWidget);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height / 2,
//       width: MediaQuery.of(context).size.width,
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: PaddingDimensions.large),
//         child: Wrap(
//           spacing: 8,
//           runSpacing: 10,
//           children: List.generate(widget.strengths.length, (index) {
//             return _StrengthWidget(
//               onClick: () {
//                 bool isSelected = widget.strengths[index].isSelected ?? false;
//
//                 widget.strengths[index] =
//                     widget.strengths[index].modify(isSelected: !isSelected);
//
//                 if (widget.strengths[index].isSelected == true) {
//                   selectedActions.add(widget.strengths[index]);
//                 } else {
//                   // remove from selected if exists
//                   selectedActions.removeWhere((element) =>
//                       widget.strengths[index].text
//                           ?.contains(element.text ?? "") ??
//                       false);
//                 }
//                 setState(() {});
//                 widget.onActionsSelected(selectedActions);
//               },
//               strengthEntity: widget.strengths[index],
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
//
// class _StrengthWidget extends StatefulWidget {
//   final VoidCallback onClick;
//   final ActionEntity strengthEntity;
//
//   const _StrengthWidget(
//       {Key? key, required this.onClick, required this.strengthEntity})
//       : super(key: key);
//
//   @override
//   State<_StrengthWidget> createState() => _StrengthWidgetState();
// }
//
// class _StrengthWidgetState extends State<_StrengthWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         widget.onClick();
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(
//             vertical: PaddingDimensions.normal,
//             horizontal: PaddingDimensions.large),
//         decoration: BoxDecoration(
//           color: widget.strengthEntity.isSelected == false
//               ? AppColors.backgroundGrey
//               : AppColors.primary_500,
//           borderRadius: BorderRadius.circular(62),
//         ),
//         // height: 100,
//         // width: 20,
//         child: Text(widget.strengthEntity.text ?? '',
//             style: TextStyles.medium(
//                 color: widget.strengthEntity.isSelected == false
//                     ? AppColors.primary_400
//                     : AppColors.neutral_0,
//                 fontSize: Dimensions.normal)),
//       ),
//     );
//   }
// }
