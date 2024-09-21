import 'package:starter/app/authentication/utils/localization/authentication_localizer.dart';

typedef ValidationPredicate = String? Function(Validation validatable);

class Validation {
  // static const emailRegex =
  //     r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
  static const emailRegex =
      r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@[a-z0-9](?:[a-z0-9-]*[a-z0-9])?(?:\.[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)*\.[a-z]{2,}$";
  static const specialCharacters = "!@#\$%^&*()_+{}[]|\"<>,.~`/:;?-=\\¥'£•¢";
  static const nameRegex = '^[a-zA-Z\u0621-\u064A ]+\$';
  final RegExp arabicLetterRegex = RegExp(r'[\u0600-\u06FF]');

  // static const nameRegex =r'[a-zA-Z\u0621-\u064A]+';
  static const passwordRegex = r'^(?=.*[a-zA-Z])(?=.*\d).*$';

  final String _text;

  Validation(String? text) : _text = text ?? '';

  String? validateAgainst(List<ValidationPredicate> validations) {
    final errors = validations
        .map((e) => e(this))
        .where((element) => element != null && element.isNotEmpty);
    if (errors.isEmpty) {
      return null;
    } else {
      return errors.join(',\n');
    }
  }

  String hasValidUrl(String value) {
    String pattern =
        r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter url';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid url';
    }
    return '';
  }

// Password validation function
  String isUpdatePasswordValid(String password) {
    if (password.length < 8) {
      return "";
    } else if (!password.contains(RegExp(r"[a-z]"))) {
      return "";
    } else if (!password.contains(RegExp(r"[A-Z]"))) {
      return "";
    } else if (!password.contains(RegExp(r"[0-9]"))) {
      return "";
    }
    // if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return "يجب ان تكون كلمه المرو الجديده ان يكون فيها رموز  ";
    // }
    return '';
  }

  // String isEmailValid(String email) {
  //   if (email.isEmpty) {
  //     return AuthenticationLocalizer.emailEmpty;
  //   } else if (!email.contains(emailRegex)) {
  //     return AuthenticationLocalizer.errorEmail;
  //   }
  //
  //   return '';
  // }

  bool isEmail() {
    final x = RegExp(emailRegex).hasMatch(_text);
    return x;
  }

  String isPasswordValid() {
    if (_text.isEmpty) {
      return "AuthenticationLocalizer.passwordError";
    }

    return '';
  }

  String? validateButNotRequired(List<ValidationPredicate> validations) {
    if (_text.isEmpty) return AuthenticationLocalizer.emailEmpty;
    return validateAgainst(validations);
  }

  String? validatePasswordButNotRequired(
      List<ValidationPredicate> validations) {
    if (_text.isEmpty) return null;
    return validateAgainst(validations);
  }

  String? validatePhone(List<ValidationPredicate> validations) {
    if (_text.isEmpty) {
      return AuthenticationLocalizer.pleaseEnterYourPhone;
    }
    return null;
    // return validateAgainst(validations);
  }

  // String? passwordValidation() {
  //   if (_text.isEmpty) {
  //     return AuthenticationLocalizer.errorPasswordEmpty;
  //   } else if (_text.length < 8) {
  //     return "Password must be at least 8 characters"; //todo add localization
  //   } else if (isPasswordInValid()) {
  //     return AuthenticationLocalizer.errorPassword;
  //   }
  //   return null;
  // }

  String? passwordValidation(String? password) {
    if (password == null || password.isEmpty) {
      return AuthenticationLocalizer.errorPasswordEmpty;
    } else if (password.length < 8) {
      return "Password length must be at least 8";
    }
    return null;
  }

  bool hasLowercaseLetter(String password) {
    RegExp lowercaseRegExp = RegExp(r'[a-z]');
    return lowercaseRegExp.hasMatch(password);
  }

  bool hasUppercaseLetter(String password) {
    RegExp uppercaseRegExp = RegExp(r'[A-Z]');
    return uppercaseRegExp.hasMatch(password);
  }

  bool hasDigit(String password) {
    RegExp digitRegExp = RegExp(r'\d');
    return digitRegExp.hasMatch(password);
  }

  bool hasOnlyDigit(String password) {
    RegExp digitRegExp = RegExp(r'^\d+$');
    return digitRegExp.hasMatch(password);
  }

  bool hasSpecialCharacter(String password) {
    RegExp specialCharRegExp = RegExp(r'[!@#\$%^&*()_+{}\[\]:;<>,.?\/\\~-]');
    return specialCharRegExp.hasMatch(password);
  }

  bool isPasswordInValid() {
    final isValid = RegExp(passwordRegex).hasMatch(_text);
    return !isValid;
  }

  String? noValidate() {
    return null;
  }

  bool isNumeric() {
    final x = double.tryParse(_text);
    return x != null;
  }

  bool isEmailOrPhone() {
    return isEmail() || isNumeric();
  }

  bool isGreaterThan(int length) {
    return _text.length > length;
  }

  bool isEqualTo(int length) {
    return _text.length == length;
  }

  bool isLessThan(int maxLength) {
    return _text.length < maxLength;
  }

  bool isTheSameAs(String text) {
    return text == _text;
  }

  bool hasSpecialCharacters() {
    return hasAnyCharacterIn(specialCharacters);
  }

  bool hasAnyCharacterIn(String pattern) {
    for (int i = 0; i < _text.length; i++) {
      for (int j = 0; j < pattern.length; j++) {
        if (_text[i] == pattern[j]) return true;
      }
    }
    return false;
  }

  String? nameValidation() {
    if (_text.isEmpty) {
      return AuthenticationLocalizer.nameIsRequired;
    } else if (isNameInValidType()) {
      return AuthenticationLocalizer.inValidName;
    } else if (_text.length < 2 || _text.length > 25) {
      return AuthenticationLocalizer.nameLengthError;
    }
    return null;
  }

  String? firstNameValidation() {
    if (_text.isEmpty == true) {
      return AuthenticationLocalizer.enterYourFirstNameError;
    } else if ((_text.length) < 2) {
      return AuthenticationLocalizer.firstnameError1;
    } else if (_text.contains(RegExp(r"[\d٠-٩]"))) {
      return AuthenticationLocalizer.firstnameError2;
    } else if (_text.contains(RegExp("\\s+"))) {
      return AuthenticationLocalizer.firstnameError5;
    } else if (!_text.contains(RegExp(r"^[A-Zء-يa-z]*$"))) {
      return AuthenticationLocalizer.firstnameError3;
    } else if (_text.length > 25) {
      return AuthenticationLocalizer.firstnameError4;
    }

    return null;
  }

  String? emailValidation() {
    if (_text.isEmpty) {
      return AuthenticationLocalizer.errorEmailEmpty;
    } else if (isEmailInValidType()) {
      return AuthenticationLocalizer.errorEmail;
    } else if (isEmailHaveCapitalCharacters()) {
      return AuthenticationLocalizer.errorEmailCapitalCharacters;
    } else if (_text.contains(' ')) {
      return AuthenticationLocalizer.emailHasSpace;
    } else if (arabicLetterRegex.hasMatch(_text)) {
      return "Only english letters allowed";
    }
    return null;
  }

  bool isEmailInValidType() {
    final isValid = RegExp(emailRegex).hasMatch(_text);
    return !isValid;
  }

  bool isEmailHaveCapitalCharacters() {
    final x = RegExp(r"[A-Z]").hasMatch(_text);
    return x;
  }

  bool isNameInValidType() {
    final isValid = RegExp(nameRegex).hasMatch(_text);
    return !isValid;
  }
}
