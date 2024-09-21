import 'package:starter/common/ui/custom_widgets/tab_bar_switcher/tab_bar_type.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';

import 'tab_bar_widget.dart';
//ignore: must_be_immutable
class TabBarSwitcher extends StatefulWidget {
  final Widget Function(int index)? pageContent;
  final List<String> tabBarItems;
  final Function(int index) onPageChanged;
  final List<Widget>? childrens;
  final double paddingBetweenItems;
  final bool centerTopBarItems;
  PageController? pageController;
  final Color? selectedColor;
  final double? paddingBetweenTopBarAndPages;
  final Widget? topWidgetAfterTabBar;
  final bool fitTabBarItems;
  final int? initialIndex;
  final TabBarType? tabBarType;
  final bool keepAlive;

  TabBarSwitcher.builder({super.key,
    required this.tabBarItems,
    required this.onPageChanged,
    required this.pageContent,
    this.centerTopBarItems = false,
    this.pageController,
    this.paddingBetweenItems = 0,
    this.selectedColor,
    this.paddingBetweenTopBarAndPages,
    this.topWidgetAfterTabBar,
    this.fitTabBarItems = false,
    this.initialIndex,
    this.tabBarType ,
    this.keepAlive = true})
      : childrens = null;

  TabBarSwitcher(
      {super.key,
        required this.childrens,
        required this.onPageChanged,
        required this.tabBarItems,
        this.centerTopBarItems = false,
        this.pageController,
        this.paddingBetweenItems = 5,
        this.selectedColor,
        this.paddingBetweenTopBarAndPages,
        this.topWidgetAfterTabBar,
        this.fitTabBarItems = false,
        this.initialIndex ,
        this.tabBarType,
        this.keepAlive = true
      })
      : pageContent = null;

  @override
  State<TabBarSwitcher> createState() => _TabBarSwitcherState();
}

class _TabBarSwitcherState extends State<TabBarSwitcher> {
  late final PageController _pageController;
  late final ValueNotifier<int> selectedIndex;
  late final List<Widget> pages;

  @override
  void initState() {
    if (widget.childrens == null) {
      pages = List.generate(
          widget.tabBarItems.length,
          (index) => KeepAlivePage(
                keepAlive: widget.keepAlive,
                child: widget.pageContent!(index),
              ));
    } else {
      pages = List.generate(
          widget.childrens!.length,
          (index) => KeepAlivePage(
                keepAlive: widget.keepAlive,
                child: widget.childrens![index],
              ));
    }

    _pageController = widget.pageController ??
        PageController(initialPage: widget.initialIndex ?? 0);
    selectedIndex = ValueNotifier(_pageController.initialPage);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ValueListenableBuilder(
          valueListenable: selectedIndex,
          builder: (context, value, child) {
            return TabBarWidget(
              selectedBgColor: widget.selectedColor,
              pageController:  _pageController,
              selectedIndex: value,
              items: widget.tabBarItems,
              fitTabBarItems: widget.fitTabBarItems,
              paddingBetweenItems: widget.paddingBetweenItems,
              centerItems: widget.centerTopBarItems,
              tabBarType: widget.tabBarType,
            );
          },
        ),

        SizedBox(
          height: widget.paddingBetweenTopBarAndPages ?? PaddingDimensions.large,
        ),

        if(widget.topWidgetAfterTabBar != null)
          widget.topWidgetAfterTabBar!,

        if (widget.childrens == null)
          Expanded(
            child: PageView.builder(
              physics: const ClampingScrollPhysics(),
              // physics:const NeverScrollableScrollPhysics(),

              scrollDirection: Axis.horizontal,
              controller:  _pageController,
              onPageChanged: (value) {
                selectedIndex.value = value;
                widget.onPageChanged(value);
              },
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return pages[index];
              },
            ),
          )
        else
          Expanded(
            child: PageView(
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              onPageChanged: (value) {
                selectedIndex.value = value;
                widget.onPageChanged(value);
              },
              children: pages,
            ),
          )
      ],
    );
  }
}

class KeepAlivePage extends StatefulWidget {
  final Widget child;
  final bool keepAlive;

  const KeepAlivePage({super.key, required this.child, required this.keepAlive});

  @override
  State<KeepAlivePage> createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin<KeepAlivePage> {
  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return widget.child;
  }
}
