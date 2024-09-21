import 'package:starter/common/ui/custom_widgets/questions/radio_choice_tile.dart';
import 'package:starter/common/utils/localization/common_localizer.dart';

class QuestionValidation {
  static String? validateQuestion(String? question) {
    if (question != null) {
      if (question.trim().length < 2) {
        return CommonLocalizer.twoCharactersValidation;
      } else if (question.trim().length > 10000) {
        return CommonLocalizer.maxCharactersValidation;
      }
    }
    return null;
  }

  static String? validateMultiQuestion(List<String>? questions) {
    if (questions != null) {
      for (var element in questions) {
        String? errorMessage;
        if (element.isEmpty) {
          errorMessage = CommonLocalizer.allQuestionsNotEmpty;
        } else if (element.trim().length < 2) {
          errorMessage = CommonLocalizer.twoCharactersValidation;
        } else if (element.trim().length > 10000) {
          errorMessage = CommonLocalizer.maxCharactersValidation;
        }
        if (errorMessage != null) {
          return errorMessage;
        }
      }
    }
    return null;
  }

  static String? validateMultiDropDownFieldQuestion(List<String>? questions) {
    if (questions != null) {
      if(questions.length < 3){
        return "Please add at least 3 answers";
      }else if (questions.length>20){
        return "Please add at most 20 answers";
      }
    }
    return null;
  }

  static String? validateRadioChoiceQuestion(String? selectedValue) {
    if (selectedValue == null) {
      return CommonLocalizer.commonEmptyValidation;
    }
    return null;
  }
}
