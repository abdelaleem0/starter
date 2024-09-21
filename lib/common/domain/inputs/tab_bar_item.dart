import 'package:flutter/material.dart';

class TabBarItem {
  final String tabBarName;
  final Widget widget;

  TabBarItem({required this.tabBarName, required this.widget});

  TabBarItem modify({String? tabBarName, Widget? widget}) {
    return TabBarItem(
        tabBarName: tabBarName ?? this.tabBarName,
        widget: widget ?? this.widget);
  }
}