import 'package:flutter/material.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/extensions.dart';

typedef TabSelectedCallback = void Function(int index);

class AppTabItem {
  final String? label;
  final Icon? icon;

  AppTabItem({this.label, this.icon});
}

class AppTabsStyle {
  final Color selectedBackgroundColor;
  final Color unselectedBackgroundColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;

  const AppTabsStyle(
      {this.selectedBackgroundColor = AppColors.primaryColor,
      this.unselectedBackgroundColor = Colors.white,
      this.selectedTextColor = AppColors.textForthColor,
      this.unselectedTextColor = AppColors.textPrimaryColor});
}

class AppTabsLayout extends StatelessWidget {
  final List<AppTabItem> items;
  final int selectedTab;
  final AppTabsStyle style;
  final TabSelectedCallback onTabSelected;

  const AppTabsLayout(
      {super.key,
      this.items = const [],
      this.selectedTab = 0,
      this.style = const AppTabsStyle(),
      required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: style.selectedBackgroundColor)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items.mapIndexed((element, index) {
            return Expanded(
              child: _buildTab(
                item: element,
                backgroundColor: index == selectedTab
                    ? style.selectedBackgroundColor
                    : style.unselectedBackgroundColor,
                textColor: index == selectedTab
                    ? style.selectedTextColor
                    : style.unselectedTextColor,
                index: index,
                callback: onTabSelected,
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTab(
      {required AppTabItem item,
      required Color backgroundColor,
      required Color textColor,
      required int index,
      TabSelectedCallback? callback}) {
    return InkWell(
      onTap: () {
        if (callback != null) {
          callback(index);
        }
      },
      child: Container(
        color: backgroundColor,
        child: Center(
          child: Text(
            item.label ?? "",
            style: TextStyles.semiBold(
                color: textColor, fontSize: Dimensions.large),
          ),
        ),
      ),
    );
  }
}
