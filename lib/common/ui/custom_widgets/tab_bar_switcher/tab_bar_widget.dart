import 'package:starter/common/ui/custom_widgets/disable_overscroll_behavior.dart';
import 'package:starter/common/ui/custom_widgets/tab_bar_switcher/purchase_tab_bar_item.dart';
import 'package:starter/common/ui/custom_widgets/tab_bar_switcher/tab_bar_type.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/extensions/media_query.dart';
import 'package:flutter/material.dart';


class TabBarWidget extends StatefulWidget {
  final PageController? pageController;
  final int selectedIndex;
  final List<String> items;
  final bool centerItems;
  final double paddingBetweenItems;
  final Color? selectedBgColor;
  final bool fitTabBarItems;
  final TabBarType? tabBarType;

  const TabBarWidget({super.key, this.pageController, required this.selectedIndex, required this.items, this.centerItems = false, required this.paddingBetweenItems, this.selectedBgColor, required this.fitTabBarItems, this.tabBarType});

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  late final List<GlobalKey> keys;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    keys = List.generate(widget.items.length, (index) => GlobalKey());

    if(widget.selectedIndex != 0){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _handleOnTapClick(
          widget.selectedIndex,
          usePageAnimation: false,
          useTabScrollAnimation: false,
        );
      });
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant TabBarWidget oldWidget) {
    if(oldWidget.selectedIndex != widget.selectedIndex){
      _handleOnTapClick(widget.selectedIndex,usePageAnimation: true);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.centerItems ? Alignment.center : AlignmentDirectional.centerStart,
      child: ScrollConfiguration(
        behavior: DisableOverscrollBehavior(),
        child: SingleChildScrollView(
          controller: scrollController,
          physics: const ClampingScrollPhysics(),
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          child: IntrinsicHeight(
            child: Container(
              decoration: _getDecorationByType(widget.tabBarType),
              padding: _getPaddingByType(widget.tabBarType),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(widget.items.length, (index){
                  return SizedBox(
                    width: widget.fitTabBarItems ? (context.width/keys.length) - keys.length * widget.paddingBetweenItems : null,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                          end: widget.tabBarType == TabBarType.purchase ? 0 : widget.paddingBetweenItems,
                          start: index == 0
                              ? (widget.tabBarType == TabBarType.purchase ? 0 : widget.paddingBetweenItems)
                              : 0
                      ),
                      child: GestureDetector(
                        key: keys[index],
                        behavior: HitTestBehavior.translucent,
                        onTap: (){
                          _handleOnTapClick(index);
                        },
                        child: widget.tabBarType == TabBarType.purchase
                            ? PurchaseTabItem(
                            selectedBgColor: widget.selectedBgColor,
                            item: widget.items[index],
                            isSelected: widget.selectedIndex == index)
                            : _TabItem(
                          selectedBgColor: widget.selectedBgColor,
                          item: widget.items[index],
                          isSelected: widget.selectedIndex == index,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleOnTapClick(int index,{bool usePageAnimation = false,bool useTabScrollAnimation = true}){

    if(widget.pageController?.hasClients ?? false){
      if(usePageAnimation){
        widget.pageController?.animateToPage(index,duration: const Duration(milliseconds: 350),curve: Curves.decelerate);
      }else{
        widget.pageController?.jumpToPage(index);
      }
    }

    //calculate item position
    double widthOfItems = 0;

    for(int i=0 ; i <= index; i++){
      final currentRenderBox = keys[i].currentContext?.findRenderObject() as RenderBox;
      double currentItemWidth = currentRenderBox.size.width;

      if(i == index && (currentItemWidth > (context.width * 0.5))){
        currentItemWidth = context.width * 0.45;
      }

      widthOfItems += currentItemWidth;
    }

    final double tabPosition = (widthOfItems - (context.width * 0.55)).clamp(0, scrollController.position.maxScrollExtent);

    if(useTabScrollAnimation){
      scrollController.animateTo(
          tabPosition,
          duration: const Duration(milliseconds: 530),
          curve: Curves.decelerate
      );
    }else{
      scrollController.jumpTo(tabPosition,);
    }

  }

  Decoration? _getDecorationByType(TabBarType? tabBarType){
    if(tabBarType == TabBarType.purchase){
      return ShapeDecoration(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.xxLargeRadius),
            side: const BorderSide(
                color: AppColors.primaryColorsSolid4Default, width: 1)),
        color: Colors.transparent,
      );
    }
    return null;
  }

  EdgeInsets? _getPaddingByType(TabBarType? tabBarType) {
    if(tabBarType == TabBarType.purchase){
      return const EdgeInsets.symmetric(
          horizontal: PaddingDimensions.small - 2,
          vertical: PaddingDimensions.small - 2);
    }
    return null;
  }

}

class _TabItem extends StatelessWidget {
  final String item;
  final bool isSelected;
  final Color? selectedBgColor;
  const _TabItem({required this.item, required this.isSelected,  this.selectedBgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: PaddingDimensions.medium,horizontal: PaddingDimensions.xLarge),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color:isSelected
            ? selectedBgColor?? AppColors.neutralColors1
            : AppColors.primaryColorsSolid4Default, width: 1),
        borderRadius: BorderRadius.circular(Dimensions.xLargeRadius),
        color: isSelected
            ? selectedBgColor?? AppColors.primaryColorsSolid4Default
            : AppColors.neutralColors1,
      ),
      child: Text(
        item,
        style: TextStyles.medium(
            fontSize: Dimensions.xLarge,
            color: isSelected
                ? AppColors.neutralColors1
                : AppColors.primaryColorsSolid4Default
        ),
      ),
    );
  }
}



