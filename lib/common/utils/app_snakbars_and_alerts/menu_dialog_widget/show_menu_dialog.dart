import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/extensions/media_query.dart';
import 'package:flutter/material.dart';

// this focusNode that is gain for keyboard
// why you need it ?
// to check inside the GestureDetector of the menu on Focusing
// if it is gain  that's mean someone take the focus
// in this example keyboard appeared and that mean it is already took the focus
// then i need to gain new one to avoid appearing on wrong position on the screen.

class MenuDialogWidget extends StatefulWidget {
  final FocusNode? focusNode;
  final List<PopupMenuEntry<dynamic>> menuItems;
  final IconData? icon;
  final double? iconSize;
  final Color iconColor;
  final Color? dividerColor;
  const MenuDialogWidget({super.key, required this.menuItems, this.icon, this.iconColor = AppColors.neutralColors6,this.dividerColor, this.iconSize, this.focusNode});

  @override
  State<MenuDialogWidget> createState() => _MenuDialogWidgetState();
}

class _MenuDialogWidgetState extends State<MenuDialogWidget> {
  // final currentFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) async{
        if(!(widget.focusNode?.hasFocus ?? false)){
          final offset = details.globalPosition;

          showMenu(
            context: context,
            elevation: 3,
            surfaceTintColor: Colors.white,
            color: Colors.white,
            shadowColor: AppColors.neutralColors6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            position: RelativeRect.fromLTRB(
              offset.dx,
              offset.dy,
              context.width - offset.dx,
              context.height - offset.dy,
            ),
            items: widget.menuItems
          );
        }else{
          FocusScope.of(context).requestFocus(FocusNode());
        }
      },
      child: Icon(
        widget.icon ?? Icons.more_horiz,
        size: widget.iconSize ?? 18,
        color: widget.iconColor,
      ),
    );
  }
}