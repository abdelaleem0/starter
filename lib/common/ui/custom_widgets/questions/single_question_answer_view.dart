import 'package:starter/common/ui/custom_widgets/app_text_fields/app_text_form_field.dart';
import 'package:starter/common/ui/custom_widgets/app_text_fields/format/input_formatters_TextFormField.dart';
import 'package:starter/common/ui/custom_widgets/indicator_scroll_view.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SingleQuestionAnswerView extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  final TextEditingController? textEditingController;
  final String title;
  final String? hint;
  final String? description;
  final String? goalTitle;
  final int? maxLines;
  final int? minLines;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onchange;
  final Widget? suffix;
  final Widget? prefix;
  final FocusNode? focusNode;
  final TextFieldType textFieldType;
  final List<TextInputFormatter>? textInputFormatter;
  final Color? borderColor;
  final int? maxLength;
  final Color? scrollbarColor;
  final String? initialAnswerValue;
  final Widget? topWidget;
  final Color? focusedBorderColor;
  final bool isTitleSemiBold;
  final Color? cursorColor;

  const SingleQuestionAnswerView(
      {super.key,
      this.formKey,
      this.textEditingController,
      required this.title,
      this.hint,
      this.description,
      this.goalTitle,
      this.maxLines,
        this.minLines,
      this.validator,
      this.onchange,
      this.suffix,
      this.prefix,
      this.focusNode,
      this.textFieldType = TextFieldType.none,
      this.textInputFormatter,
      this.borderColor,
      this.maxLength,
      this.scrollbarColor,
      this.topWidget,
      this.initialAnswerValue,
        this.focusedBorderColor,
        this.isTitleSemiBold = true,
        this.cursorColor,
      })
      : assert(
          initialAnswerValue == null || textEditingController == null,
          'Cannot provide both initialValue and textEditingController',
        );

  @override
  State<SingleQuestionAnswerView> createState() =>
      _SingleQuestionAnswerViewState();
}

class _SingleQuestionAnswerViewState extends State<SingleQuestionAnswerView> {
  FocusNode? _focusNode;
  ScrollController scrollController = ScrollController();
  TextEditingController? textEditingController;

  @override
  void initState() {
    textEditingController = widget.textEditingController;
    if (widget.textEditingController == null) {
      textEditingController = TextEditingController();
      textEditingController?.text = widget.initialAnswerValue ?? "";
    }

    if (widget.focusNode != null) {
      _focusNode = widget.focusNode;
    } else {
      _focusNode = FocusNode();
    }
    _focusNode?.requestFocus();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.initialAnswerValue != null) {
      textEditingController?.dispose();
    }
    scrollController.dispose();
    _focusNode?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IndicatorScrollView(
      scrollController: scrollController,
      scrollbarColor: widget.scrollbarColor ?? AppColors.primaryColorsSolid4Default,
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
              widget.topWidget ?? const SizedBox(),
              if (widget.topWidget == null) ...[
                Text(
                  widget.title,
                  style:widget.isTitleSemiBold? TextStyles.semiBold(
                      color: AppColors.neutralColors7,
                      height: 1.3,
                      fontSize: Dimensions.xxLarge):TextStyles.medium(
                      color: AppColors.neutralColors7,
                      height: 1.3,
                      fontSize: Dimensions.xLarge),
                ),
                if (widget.description == null || widget.description == "")
                  const SizedBox(
                    height: PaddingDimensions.xxxLarge,
                  ),
                if (widget.description != null && widget.description != "") ...[
                  const SizedBox(
                    height: PaddingDimensions.xLarge,
                  ),
                  Text(
                    widget.description ?? "",
                    style: TextStyles.regular(
                      color: AppColors.neutralColors7,
                      height: 1.2,
                      fontSize: Dimensions.xLarge,
                    ),
                  ),
                  const SizedBox(
                    height: PaddingDimensions.normal,
                  ),
                ],
              ],
              AppTextFormField(
                focusBorderColor: widget.focusedBorderColor ?? AppColors.primaryColorsSolid4Default,
                maxLength: widget.maxLength ?? 10000,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: PaddingDimensions.medium,
                  horizontal: PaddingDimensions.large,
                ),
                maxLines: widget.maxLines,
                minLines: widget.minLines??4,
                onchange: (data) {
                  setState(() {});
                  if (widget.onchange != null) {
                    widget.onchange!(data);
                  }
                },
                controller: textEditingController,
                hint: widget.hint,
                hintStyle: TextStyles.regular(
                  fontSize: Dimensions.xLarge,
                  color: AppColors.neutralColors5,
                  height: 1.3,
                ),
                textDirection: TextDirection.ltr,
                fontSize: Dimensions.xLarge,
                prefix: widget.prefix,
                suffix: widget.suffix,
                errorTextFontSize: Dimensions.xLarge,
                textColor: AppColors.neutralColors7,
                textFieldType: TextFieldType.normal,
                borderColor: widget.borderColor ?? AppColors.neutralColors3,
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
      ),
    );
  }
}
