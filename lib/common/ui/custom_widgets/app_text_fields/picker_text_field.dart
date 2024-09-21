import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/common.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'text_field_utils.dart';

class PickerTextField extends StatefulWidget {
  final bool isRequired;
  final bool isDark;
  final void Function(int? selectedIndex) onValueChanged;
  final int? initialSelectedIndex;
  final List<String> values;
  final String errorMessage;
  final bool addAllChoice;
  final String? allChoiceText;

  const PickerTextField({
    super.key,
    required this.onValueChanged,
    this.isRequired = true,
    this.isDark = true,
    this.initialSelectedIndex,
    this.values = const [],
    this.errorMessage = "Please select a value",
    this.addAllChoice = false,
    this.allChoiceText,
  });

  @override
  State<PickerTextField> createState() => _PickerTextFieldState();
}

class _PickerTextFieldState extends State<PickerTextField> {
  final _pickerController = TextEditingController();
  late final _PickerValuesController _pickerValuesController;
  int? _selectedIndex;

  @override
  void initState() {
    _pickerValuesController = _PickerValuesController(
        widget.values, widget.addAllChoice, widget.allChoiceText);
    final initialIndex =
        _pickerValuesController.getInitialIndex(widget.initialSelectedIndex);
    if (initialIndex != null) {
      setItemSelected(initialIndex);
    }
    super.initState();
  }

  void onItemSelected(int index) {
    setItemSelected(index);
    widget.onValueChanged(_pickerValuesController.getSelectedIndex(index));
  }

  void setItemSelected(int index) {
    _selectedIndex = index;
    _pickerController.text = _pickerValuesController.values[index];
  }

  void onPickerPressed() {
    if (_pickerValuesController.values.isEmpty) {
      // showWarningSnackBar(context, CommonLocalizer.noValuesError);
      return;
    }
    if (_selectedIndex == null) {
      onItemSelected(0);
    }
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
                color: AppColors.backgroundForthColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            height: 300,
            width: getWindowSize(context).width,
            child: CupertinoPicker(
              scrollController:
                  FixedExtentScrollController(initialItem: _selectedIndex ?? 0),
              itemExtent: Dimensions.pickerItemHeight,
              onSelectedItemChanged: onItemSelected,
              children: _getValueWidgets(),
            ),
          );
        });
  }

  List<Widget> _getValueWidgets() {
    return _pickerValuesController.values.map((e) {
      return Center(
        child: Text(
          e,
          style: TextStyles.regular(
              color: AppColors.textPrimaryColor, fontSize: Dimensions.xLarge),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onPickerPressed,
      controller: _pickerController,
      decoration: authenticationInputDecoration(
          isDark: widget.isDark,
          suffixIcon: Icon(
            Icons.keyboard_arrow_down,
            size: 24,
            color: widget.isDark
                ? AppColors.textForthColor
                : AppColors.textPrimaryColor,
          )),
      style: TextStyles.regular(
          color: AppColors.textPrimaryColor, fontSize: Dimensions.normal),
      readOnly: true,
      validator: (text) {
        if (widget.isRequired) {
          return _selectedIndex != null ? null : widget.errorMessage;
        } else {
          return null;
        }
      },
    );
  }
}

class _PickerValuesController {
  final List<String> _rawValues;
  final bool _addAllChoice;
  final String? _allChoiceText;

  final List<String> values = [];

  _PickerValuesController(
    this._rawValues,
    this._addAllChoice,
    this._allChoiceText,
  ) {
    if (_addAllChoice) {
      values.add(_allChoiceText ?? "All");
    }

    values.addAll(_rawValues);
  }

  int? getInitialIndex(int? initialSelectedIndex) {
    if (_addAllChoice) {
      if ((initialSelectedIndex ?? 0) >= values.length) return null;
      if (initialSelectedIndex == null) {
        return 0;
      } else {
        return initialSelectedIndex + 1;
      }
    } else {
      if (values.isEmpty) return null;
      return initialSelectedIndex;
    }
  }

  int? getSelectedIndex(int selectedIndex) {
    if (_addAllChoice) {
      if (selectedIndex > 0) {
        return selectedIndex - 1;
      } else {
        return null;
      }
    } else {
      return selectedIndex;
    }
  }
}
