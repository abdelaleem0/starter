import 'package:flutter/services.dart';

class NoStartWithSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.startsWith(' ')) {
      final String trimedText = newValue.text.trimLeft();

      return TextEditingValue(
        text: trimedText,
        selection: TextSelection(
          baseOffset: trimedText.length,
          extentOffset: trimedText.length,
        ),
      );
    }

    return newValue;
  }
}


class NoStartsOrEndsWithEmptyLinesFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String text = newValue.text;
    TextSelection selection = newValue.selection;

    // Preserve cursor position before any replacements
    int newSelectionIndex = selection.baseOffset;

    // Remove any newlines at the beginning of the text
    if (text.startsWith('\n')) {
      text = text.replaceFirst(RegExp(r'^\n+'), '');
      newSelectionIndex -= 1;
    }

    // Remove any consecutive newlines
    final consecutiveNewlines = RegExp(r'\n{2,}');
    text = text.replaceAllMapped(consecutiveNewlines, (match) {
      if (match.start <= newSelectionIndex) {
        newSelectionIndex -= (match.end - match.start - 1);
      }
      return '\n';
    });

    // Ensure newlines are only after at least one character
    // Replace any newlines that are not preceded by a character with an empty string
    final newlineWithoutChar = RegExp(r'(^|\n)(\n)');
    text = text.replaceAllMapped(newlineWithoutChar, (match) {
      if (match.start <= newSelectionIndex) {
        newSelectionIndex -= 1;
      }
      return match.group(2)!.isNotEmpty ? '' : match.group(1)!;
    });

    // Ensure the new selection index is within the bounds of the new text length
    newSelectionIndex = newSelectionIndex.clamp(0, text.length);

    // Return the new TextEditingValue with the adjusted text and selection
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: newSelectionIndex),
    );
  }
}
