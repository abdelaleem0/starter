import 'package:flutter/material.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? action;
  final String? backgroundImage;
  final Widget? leading;
  final Widget? title;
  final bool? isRotated;
  final Color color;
  final double? leadingWidth;
  final double? toolbarHeight;
  final double titleSpacing;
  final Color? backgroundColor;
  final Widget? bottomAppBar;

  const MyAppbar({
    super.key,
    this.action,
    this.backgroundImage,
    this.leading,
    this.title,
    this.isRotated,
    this.color = AppColors.appBackgroundColor,
    this.leadingWidth,
    this.toolbarHeight,
    this.titleSpacing = 0,
    this.backgroundColor,
    this.bottomAppBar,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: toolbarHeight ?? 56.0,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(),
        // child: leading,
      ),
      backgroundColor: backgroundColor,
      leading: leading,
      title: title,
      leadingWidth: leadingWidth,
      actions: action,
      centerTitle: true,
      titleSpacing: titleSpacing,
      bottom: bottomAppBar != null
          ? PreferredSize(
              preferredSize: Size(double.infinity, toolbarHeight ?? 0),
              child: bottomAppBar!,
            )
          : null,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.infinity, toolbarHeight ?? 56);

  static MyAppbar gradientAppBar({
    required Widget title,
    double? toolbarHeight,
    Widget? leading,
    List<Widget>? action,
    Widget? bottomAppBar,
  }) {
    return MyAppbar(
      title: title,
      toolbarHeight: toolbarHeight,
      bottomAppBar: bottomAppBar,
      action: action,
    );
  }

  static MyAppbar consultantAvailableDateAppBar({
    double? toolbarHeight,
    Widget? leading,
    required final Widget bottomAppBar,
  }) {
    return MyAppbar(
      backgroundColor: AppColors.forthColor,
      toolbarHeight: toolbarHeight,
      leading: leading,
      bottomAppBar: bottomAppBar,
    );
  }

  static MyAppbar normalAppbar({
    Color backgroundColor = Colors.transparent,
    required Widget leading,
    double? leadingWidth,
     Widget? title,
    Widget? bottomAppBar,
    double? toolBarHeight,
  }) {
    return MyAppbar(
      title: title,
      backgroundColor: backgroundColor,
      leading: leading,
      leadingWidth: leadingWidth ?? 40,
      bottomAppBar: bottomAppBar,
      toolbarHeight: toolBarHeight ,
    );
  }

  static MyAppbar headerAppbar({
    Color backgroundColor = AppColors.backgroundTertiaryColor,
    double? leadingWidth,
    required Widget title,
  }) {
    return MyAppbar(
      title: title,
      backgroundColor: backgroundColor,
      leadingWidth: leadingWidth ?? 80,
    );
  }

  static MyAppbar appbarWithAction({
    Color backgroundColor = AppColors.backgroundTertiaryColor,
    required List<Widget> action,
  }) {
    return MyAppbar(
      backgroundColor: backgroundColor,
      action: action,
    );
  }
}
