import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/extensions/media_query.dart';
import 'package:flutter/material.dart';

class TabBarSecondShapeWidget extends StatefulWidget {
  final PageController pageController;
  final int selectedIndex;
  final List<String> items;
  final bool centerItems;
  final double paddingBetweenItems;
  const TabBarSecondShapeWidget({super.key, required this.pageController, required this.selectedIndex, required this.items,  this.centerItems = false, required this.paddingBetweenItems});

  @override
  State<TabBarSecondShapeWidget> createState() => _TabBarSecondShapeWidgetState();
}

class _TabBarSecondShapeWidgetState extends State<TabBarSecondShapeWidget> {
  late final List<GlobalKey> keys;
  double dividerWidth = 0;
  double lineWidth = 0;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    keys = List.generate(widget.items.length, (index) => GlobalKey());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //calculate grey line width
      if(widget.centerItems){
        for(GlobalKey key in keys){
          final renderBox = key.currentContext?.findRenderObject() as RenderBox;
          lineWidth+= renderBox.size.width;
        }
      }

      final renderBox = keys[0].currentContext?.findRenderObject() as RenderBox;
      dividerWidth = renderBox.size.width;
      setState(() {});
    });

    super.initState();
  }

  @override
  void didUpdateWidget(covariant TabBarSecondShapeWidget oldWidget) {
    if(oldWidget.selectedIndex != widget.selectedIndex){
     _handleOnTapClick(widget.selectedIndex,usePageAnimation: true);//todo:
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:PaddingDimensions.normal),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: PaddingDimensions.large),
            child: SizedBox(
              height: 1,
              width: widget.centerItems ? lineWidth : context.width,
              child:  ColoredBox(
                color: AppColors.neutral_200.withOpacity(.6),
              ),
            ),
          ),

          const SizedBox(height: PaddingDimensions.small,),

          Align(
            alignment: widget.centerItems ? Alignment.center : AlignmentDirectional.centerStart,
            child: SizedBox(
              height: PaddingDimensions.xxLarge +12,
              child: SingleChildScrollView(
                controller: scrollController,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(widget.items.length, (index){
                      return Padding(
                        padding: EdgeInsetsDirectional.only(
                            end: index == widget.items.length-1 ? 0 : widget.paddingBetweenItems
                        ),
                        child: GestureDetector(
                          key: keys[index],
                          behavior: HitTestBehavior.translucent,
                          onTap: (){
                            _handleOnTapClick(index);
                          },
                          child: _TabItem(
                            item: widget.items[index],
                            isSelected: widget.selectedIndex == index,
                            dividerWidth: dividerWidth,
                          ),
                        ),
                      );
                    }).toList(),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  _handleOnTapClick(int index,{bool usePageAnimation = false}){

    //calculate divider width
    final renderBox = keys[index].currentContext?.findRenderObject() as RenderBox;
    final itemWidth = renderBox.size.width;
    dividerWidth = itemWidth;

    if(usePageAnimation){
      widget.pageController.animateToPage(index,duration: const Duration(milliseconds: 350),curve: Curves.decelerate);
    }else{
      widget.pageController.jumpToPage(index);
    }

    //calculate item position
    double widthOfItems = 0;

    for(int i=0 ; i <= index; i++){
      final currentRenderBox = keys[i].currentContext?.findRenderObject() as RenderBox;
      double currentItemWidth = currentRenderBox.size.width;

      if(i == index && (currentItemWidth > (context.width * 0.5))){
        currentItemWidth = context.width * 0.45;
      }

      widthOfItems += currentItemWidth ;
    }

      final double tabPosition = widthOfItems - (context.width * 0.55);

    scrollController.animateTo(
        tabPosition,
        duration: const Duration(milliseconds: 530),
        curve: Curves.decelerate
    );
  }
}

class _TabItem extends StatelessWidget {
  final String item;
  final bool isSelected;
  final double dividerWidth;
  const _TabItem({required this.item, required this.isSelected, required this.dividerWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Dimensions.normal,
              horizontal: Dimensions.normal
            ),

            child: Text(
              item,
              style: TextStyles.medium(
                  fontSize: Dimensions.xLarge,
                  color: isSelected
                      ? AppColors.primary_500
                      : AppColors.neutral_200
              ),),
          ),
        ),

        const Spacer(),

        AnimatedSize(
          duration: const Duration(milliseconds:550),
          curve : Curves.ease,
          child: SizedBox(
            height: 1.7,
            width:isSelected ? dividerWidth : 0,
            child: const ColoredBox(
              color: AppColors.primary_500,
            ),
          ),
        )
      ],
    );
  }
}

