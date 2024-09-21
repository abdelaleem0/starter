import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/extensions.dart';
import 'package:starter/common/utils/radio_button/custom_radio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RadioChoiceTile<T> extends StatefulWidget {
  final String? title;
  final String? description;
  final String? goalTitle;
  final List<RadioModel<T>> items;
  final List<String> tilesHint;
  final RadioModel<T>? groupValue;
  final Color? radioBackgroundTileColor;
  final ValueChanged<RadioModel<T>?>? onChanged;
  final ScrollPhysics? physics;
  final bool? showAsHorizontal;

  RadioChoiceTile(
      {super.key,
        this.title,
        this.description,
        this.goalTitle,
        this.onChanged,
        required this.items,
        this.groupValue,
        this.radioBackgroundTileColor,
        required this.tilesHint,
        this.physics,
        this.showAsHorizontal}) {
    assert(tilesHint.length == items.length);
  }

  @override
  State<RadioChoiceTile<T>> createState() => _RadioChoiceTileState<T>();
}

class _RadioChoiceTileState<T> extends State<RadioChoiceTile<T>> {
  RadioModel<T>? groupValue;
  List<RadioModel<T>> radioList = [];

  @override
  void initState() {
    radioList = widget.items.mapIndexed((e, i) {
      if (widget.groupValue != null && widget.groupValue == e) {
        groupValue = e;
      }
      return e;
    }).toList();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant RadioChoiceTile<T> oldWidget) {
    // if (oldWidget.groupValue != widget.groupValue) {
    //   // int index = widget.items.indexOf(widget.groupValue as RadioModel<T>);
    //   // if (index != -1) {
    //   // }
    // }
    groupValue = widget.groupValue;

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (widget.goalTitle != null) ...[
            Text(
              widget.goalTitle ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.regular(
                color: AppColors.neutralColors7,
                fontSize: Dimensions.xLarge,
              ),
            ),
            const SizedBox(height: PaddingDimensions.normal),
          ],
          if (widget.title != null) ...[
            Padding(
              padding: const EdgeInsets.only(
                bottom: PaddingDimensions.small,
              ),
              child: Text(
                widget.title ?? '',
                style: TextStyles.semiBold(
                  color: AppColors.neutralColors7,
                  height: 1.3,
                  fontSize: Dimensions.xxLarge,
                ),
              ),
            ),
            const SizedBox(height: PaddingDimensions.xxLarge),
          ],
          if (widget.description != null)
            Padding(
              padding: const EdgeInsets.only(
                bottom: PaddingDimensions.large,
              ),
              child: Text(
                widget.description ?? "",
                style: TextStyles.regular(
                  color: AppColors.neutralColors7,
                  height: 1.2,
                  fontSize: Dimensions.xLarge,
                ),
              ),
            ),
          if(widget.showAsHorizontal == true)...[
            IntrinsicHeight(
              child: Row(
                children: widget.items
                    .mapIndexed((e, index) => Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      if (widget.onChanged != null) {
                        groupValue = radioList[index];
                        widget.onChanged!(radioList[index]);
                        setState(() {});
                      }
                    },
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          CustomRadio<RadioModel>(
                            value: radioList[index],
                            groupValue: groupValue,
                            activeColor:
                            widget.radioBackgroundTileColor ??
                                AppColors.primaryColorsSolid4Default,
                            onChanged: (value) {
                              if (widget.onChanged != null) {
                                groupValue = radioList[index];
                                widget.onChanged!(radioList[index]);
                                setState(() {});
                              }
                            },
                          ),
                          const SizedBox(height: PaddingDimensions.medium,),
                          Text(
                            widget.tilesHint[index],
                            textAlign: TextAlign.start,
                            style: TextStyles.regular(
                                color: AppColors.neutralColors7,
                                fontSize: Dimensions.xLarge),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
                    .toList(),
              ),
            )
          ]else...[
            ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: PaddingDimensions.small,
              ),
              physics: widget.physics,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (widget.onChanged != null) {
                      groupValue = radioList[index];
                      widget.onChanged!(radioList[index]);
                      setState(() {});
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.tilesHint[index],
                              textAlign: TextAlign.start,
                              style: TextStyles.regular(
                                color: AppColors.neutralColors7,
                                fontSize: Dimensions.xLarge,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: PaddingDimensions.normal,
                          ),
                          IgnorePointer(
                            child: CustomRadio<RadioModel>(
                              value: radioList[index],
                              groupValue: groupValue,
                              activeColor: widget.radioBackgroundTileColor ?? AppColors.primaryColorsSolid4Default,
                              onChanged: (value) {
                                if (widget.onChanged != null) {
                                  groupValue = radioList[index];
                                  widget.onChanged!(radioList[index]);
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: PaddingDimensions.medium),
                    ],
                  ),
                );
              },
              itemCount: widget.items.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.zero,
            )
          ]

        ]);
  }
}

class RadioModel<T> extends Equatable{
  final int id;
  final T? value;

  const RadioModel({required this.id, this.value});

  @override
  List<Object?> get props => [id, value];
}
