

import 'package:starter/common/ui/custom_widgets/app_text_fields/app_text_form_field.dart';
import 'package:starter/common/ui/custom_widgets/app_text_fields/format/input_formatters_TextFormField.dart';
import 'package:starter/common/ui/custom_widgets/indicator_scroll_view.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MultiQuestionAnswerView extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  // final List<TextEditingController>? textEditingControllers;
  final List<String> initialValues;
  final String? title;
  final String? goalTitle;
  final List<String>? descriptionList;
  final List<String>? hintList;
  final int? maxLines;
  final FormFieldValidator<String>? validator;
  final void Function(String value , int index )? onchange;
  final Widget? suffix;
  final Widget? prefix;
  final FocusNode? focusNode;
  final TextFieldType textFieldType;
  final List<TextInputFormatter>? textInputFormatter;
  final Color? borderColor;
  final int? maxLength;
  final Color? scrollbarColor;
  final Color? focusedBorderColor;
  final bool isTitleSemiBold;
  final bool isDescriptionSemiBold;
  final Color? cursorColor;


  const MultiQuestionAnswerView(
      {super.key,
        this.formKey,
        this.title,
        this.goalTitle,
        this.descriptionList,
        this.maxLines,
        this.validator,
        this.onchange,
        this.suffix,
        this.prefix,
        this.focusNode,
        this.textFieldType = TextFieldType.none,
        this.textInputFormatter,
        this.borderColor,
        this.maxLength,
        required this.initialValues,
        this.scrollbarColor,
        this.hintList,
        this.focusedBorderColor,
        this.isTitleSemiBold = true,
        this.isDescriptionSemiBold=false,
        this.cursorColor,
      });

  @override
  State<MultiQuestionAnswerView> createState() =>
      _MaltyQuestionAnswerViewViewState();
}

class _MaltyQuestionAnswerViewViewState extends State<MultiQuestionAnswerView> {
  FocusNode? _focusNode;
  ScrollController scrollController = ScrollController();

  List<TextEditingController> textEditingControllers = [];
  bool isFromOutside = false;

  @override
  void initState() {

    for (var i = 0; i < widget.initialValues.length; i++) {
      textEditingControllers.add(TextEditingController(text: widget.initialValues[i]));
    }

    if (widget.focusNode != null) {
      _focusNode = widget.focusNode;
    } else {
      _focusNode = FocusNode();
    }
    _focusNode?.requestFocus();

    if (widget.textInputFormatter != null) {
      widget.textInputFormatter!.add(NoStartWithSpaceFormatter());
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    for (var element in textEditingControllers) {
      element.dispose();
    }
    scrollController.dispose();
    _focusNode?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IndicatorScrollView(
      scrollController: scrollController,
      scrollbarColor:widget.scrollbarColor ?? AppColors.primaryColorsSolid4Default,
      child: GestureDetector(
        onTap: () {
          _focusNode?.requestFocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: PaddingDimensions.xxLarge,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(widget.goalTitle != null)...[
                Text(
                  widget.goalTitle!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.regular(
                    color: AppColors.neutralColors7,
                    fontSize: Dimensions.xLarge,
                  ),
                ),
                const SizedBox(
                  height: PaddingDimensions.normal,
                ),
              ],
              if(widget.title != null)...[
                Text(
                  widget.title!,
                  style: widget.isTitleSemiBold? TextStyles.semiBold(
                      color: AppColors.neutralColors7,
                      height: 1.3,
                      fontSize: Dimensions.xxLarge):TextStyles.medium(
                      color: AppColors.neutralColors7,
                      height: 1.3,
                      fontSize: Dimensions.xLarge),
                ),
                const SizedBox(
                  height: PaddingDimensions.xxLarge,
                ),
              ],
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) => const SizedBox(height: PaddingDimensions.large,),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: textEditingControllers.length,
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.descriptionList != null) ...[
                      Text(
                        widget.descriptionList?[index] ?? "",
                        style: widget.isDescriptionSemiBold?TextStyles.semiBold(
                            color: AppColors.neutralColors7,
                            height: 1.3,
                            fontSize: Dimensions.xxLarge):TextStyles.medium(
                          color: AppColors.neutralColors7,
                          height: 1.2,
                          fontSize: Dimensions.xLarge,
                        ),
                      ),
                      const SizedBox(
                        height: PaddingDimensions.normal,
                      ),
                    ],
                    AppTextFormField(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: PaddingDimensions.medium,
                        horizontal: PaddingDimensions.large,
                      ),
                      maxLines: widget.maxLines,
                      maxLength: widget.maxLength ?? 10000,
                      minLines: 4,
                      onchange: (data) {
                        setState(() {});
                        if (widget.onchange != null) {
                          widget.onchange!(data , index);
                        }
                      },
                      controller: textEditingControllers[index],
                      textDirection: TextDirection.ltr,
                      fontSize: Dimensions.xLarge,
                      prefix: widget.prefix,
                      suffix: widget.suffix,
                      focusBorderColor: widget.focusedBorderColor ?? AppColors.primaryColorsSolid4Default,
                      hint: widget.hintList?[index]=="Like when I ..."? '' : widget.hintList?[index] ?? "",
                      hintStyle: TextStyles.regular(
                          fontSize: Dimensions.xLarge,
                          color: AppColors.neutralColors5),
                      errorTextFontSize: Dimensions.xLarge,
                      textColor: AppColors.neutralColors7,
                      textFieldType: TextFieldType.normal,
                      borderColor:
                      widget.borderColor ?? AppColors.neutralColors3,
                      cursorColor: widget.cursorColor,
                      inputFormatters: widget.textInputFormatter ??
                          [
                            NoStartWithSpaceFormatter(),
                            NoStartsOrEndsWithEmptyLinesFormatter()
                          ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
