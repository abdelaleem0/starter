import 'package:starter/common/ui/custom_widgets/drop_down_menu/drop_down.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/extensions/extensions.dart';
import 'package:starter/common/utils/extensions/media_query.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SingleSelectDropDown<T> extends StatefulWidget {
  final List<T> itemsValues;
  final List<String> showItems;
  final String? selectedText;
  final String? hint;
  final T? value;
  final void Function(T? selectedItem) onChanged;
  final String? Function(Object?)? validator;
  final String? label;
  final bool? hasError;

  const SingleSelectDropDown(
      {super.key,
      required this.itemsValues,
      required this.showItems,
      required this.onChanged,
      this.hint,
      this.value,
      this.selectedText,
      this.validator,
      this.label,
      this.hasError});

  @override
  State<SingleSelectDropDown<T>> createState() =>
      _SingleSelectDropDownState<T>();
}

class _SingleSelectDropDownState<T> extends State<SingleSelectDropDown<T>> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Text(widget.label ?? '',
                style: TextStyles.medium(
                  color: AppColors.neutralColors7,
                  fontSize: Dimensions.xLarge,
                )),
          const SizedBox(
            height: PaddingDimensions.small,
          ),
          Container(
            alignment: Alignment.center,
            child: DropdownButtonHideUnderline(
              child: CustomDropdownButton<T>(
                isExpanded: true,
                hint: Padding(
                  padding: const EdgeInsets.only(
                    left: PaddingDimensions.large,
                    right: PaddingDimensions.large,
                  ),
                  child: Text(
                    widget.hint ?? "",
                    style: TextStyles.regular(
                      fontSize: Dimensions.xLarge,
                      color: AppColors.neutralColors5,
                    ),
                  ),
                ),
                onMenuStateChange: (isOpen) {
                  setState(() {
                    _isOpen = isOpen;
                  });
                },
                items: widget.showItems.mapIndexed((item, index) {
                  final itemValue = widget.itemsValues[index];
                  return DropdownMenuItem<T>(
                    value: itemValue,
                    child: Container(
                      width: context.width,
                      height: 52,
                      alignment: AlignmentDirectional.centerStart,
                      padding: const EdgeInsets.symmetric(
                        horizontal: PaddingDimensions.large,
                      ),
                      decoration: BoxDecoration(
                        color: (widget.value != itemValue)
                            ? AppColors.neutralColors1
                            : AppColors.neutralColors1,
                      ),
                      child: Text(
                        item,
                        style: TextStyles.medium(
                          fontSize: Dimensions.large,
                          color: AppColors.neutralColors7,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                value: widget.value,
                onChanged: widget.onChanged,
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  // elevation: 1,
                  useRootNavigator: true,
                  offset: const Offset(0, -10),
                  scrollbarTheme: ScrollbarThemeData(
                    thumbColor: WidgetStateProperty.all<Color>(
                        AppColors.neutralColors1),
                    thickness: WidgetStateProperty.all<double>(8),
                  ),
                  scrollPadding: const EdgeInsets.all(PaddingDimensions.small),
                  decoration: BoxDecoration(
                    color: AppColors.neutralColors1,
                    border:
                        Border.all(width: 1, color: AppColors.neutralColors3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                iconStyleData: IconStyleData(
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: PaddingDimensions.normal),
                    child: _isOpen
                        ? const Icon(
                            Iconsax.arrow_up_15,
                            size: IconDimensions.medium,
                            color: AppColors.neutralColors6,
                          )
                        : const Icon(
                            Iconsax.arrow_down5,
                            size: IconDimensions.medium,
                            color: AppColors.neutralColors6,
                          ),
                  ),
                ),
                buttonStyleData: ButtonStyleData(
                    height: Dimensions.buttonMediumHeight,
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.neutralColors1,
                      border: Border.all(
                        color: _getFieldStateColor(widget.hasError ?? false),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    overlayColor: WidgetStateProperty.resolveWith(
                        (states) => Colors.white)),
                selectedItemBuilder: (context) {
                  return widget.showItems.map(
                    (item) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: PaddingDimensions.large,
                        ),
                        child: Text(
                          widget.selectedText ?? "Select your city",
                          style: TextStyles.medium(
                              fontSize: Dimensions.large,
                              color: AppColors.neutralColors7),
                          maxLines: 1,
                        ),
                      );
                    },
                  ).toList();
                },
                menuItemStyleData: const MenuItemStyleData(
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getFieldStateColor(bool hasError) {
    if (hasError) {
      // If Field Has Error
      return AppColors.primaryColorsSolid4Default;
    } else if (_isOpen) {
      // If Field Filled
      return AppColors.primaryColorsSolid4Default;
    } else if (widget.value != null) {
      return AppColors.neutralColors3;
    } else {
      // Un Focus Or Un Selected Color
      return AppColors.neutralColors3;
    }
  }
}
