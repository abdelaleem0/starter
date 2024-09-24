
import 'package:starter/di/app_injector.dart';
import 'package:starter/di/localizations_container.dart';

import 'authentication_localization.dart';

class AuthenticationLocalizer {
  AuthenticationLocalizer._();

  static AuthenticationLocalization get _localizer =>
      injector.get<LocalizationsContainer>().getLocalizations();

  static String get oR => _localizer.translate("oR");
  static String get currentPassword => _localizer.translate("currentPassword");
  static String get pleaseEnterCurrentPassword => _localizer.translate("pleaseEnterCurrentPassword");
  static String get login => _localizer.translate("login");
  static String get otpError => _localizer.translate("otpError");
  static String get emailError => _localizer.translate("emailError");
  static String get email => _localizer.translate("email");
  static String get password => _localizer.translate("password");
  static String get pleaseEnterEmail =>
      _localizer.translate("pleaseEnterEmail");
  static String get errorEmail => _localizer.translate("errorEmail");
  static String get emailEmpty => _localizer.translate("emailEmpty");
  static String get passwordError => _localizer.translate("passwordError");
  static String get updatePasswordError =>
      _localizer.translate("updatePasswordError");
  static String get enter => _localizer.translate("enter");
  static String get repeatUpdatePasswordError => _localizer.translate("repeatUpdatePasswordError");
  static String get forgetPassword => _localizer.translate("forgetPassword");
  static String get here => _localizer.translate("here");
  static String get consultant => _localizer.translate("consultant");
  static String get verificationError =>
      _localizer.translate("verificationError");
  static String get alreadyHaveAccount =>
      _localizer.translate("alreadyHaveAccount");
  static String get searchByCountryName =>
      _localizer.translate("searchByCountryName");
  static String get send => _localizer.translate("send");
  static String get userText => _localizer.translate("userText");
  static String get next => _localizer.translate("next");
  static String get nickName => _localizer.translate("nickName");
  static String get measureNickName => _localizer.translate("measureNickName");
  static String get activeNickName => _localizer.translate("activeNickName");
  static String get lastName => _localizer.translate("lastName");
  static String get firstName => _localizer.translate("firstName");
  static String get newEnterPassword =>
      _localizer.translate("newEnterPassword");
  static String get surePassword => _localizer.translate("surePassword");
  static String get confirmation => _localizer.translate("confirmation");
  static String get changePassword => _localizer.translate("changePassword");
  static String get createPasswordSuccess => _localizer.translate("createPasswordSuccess");
  static String get pleaseLoginFirst =>
      _localizer.translate("pleaseLoginFirst");

  static String get phoneIsNotValid => _localizer.translate("phoneIsNotValid");
  static String get pleaseEnterYourPhone =>
      _localizer.translate("pleaseEnterYourPhone");
  static String get phoneNumber => _localizer.translate("phoneNumber");
  static String get whenRegisterOnTatmeenYouAgree => _localizer.translate("whenRegisterOnTatmeenYouAgree");


  static String get termsAndConditions => _localizer.translate("termsAndConditions");
  static String get and => _localizer.translate("and");
  static String get privacyPolicy => _localizer.translate("privacyPolicy");


  static String get appSpecific => _localizer.translate("appSpecific");
  static String get enterYourVerificationCode =>
      _localizer.translate("enterYourVerificationCode");
  static String get sendActiveCodeByWhatsApp =>
      _localizer.translate("sendActiveCodeByWhatsApp");
  static String get sendActiveCodeBySMS =>
      _localizer.translate("sendActiveCodeBySMS");
  static String get resendActiveCodeAfter =>
      _localizer.translate("resendActiveCodeAfter");
  static String get resendActiveCodeBySMS =>
      _localizer.translate("resendActiveCodeBySMS");
  static String get resendActiveCodeByWhatsApp =>
      _localizer.translate("resendActiveCodeByWhatsApp");
  static String get nameMustNotLessThanTwoLetters =>
      _localizer.translate("nameMustNotLessThanTwoLetters");
  static String get nameNotHaveSpecialCharacters =>
      _localizer.translate("nameNotHaveSpecialCharacters");

  static String get enterYourFirstName =>
      _localizer.translate("enterYourFirstName");
  static String get continueAgreeToStarter =>
      _localizer.translate("continueAgreeToStarter");
  static String get dontHaveAnAccount =>
      _localizer.translate("dontHaveAnAccount");
  static String get enterYourFirstNameError =>
      _localizer.translate("enterYourFirstNameError");
  static String get welcomeMessage =>
      _localizer.translate("welcomeMessage");
  static String get welcomeApp =>
      _localizer.translate("welcomeApp");
  static String get signUp =>
      _localizer.translate("signUp");
  static String get exName =>
      _localizer.translate("exName");
  static String get female =>
      _localizer.translate("female");
  static String get male =>
      _localizer.translate("male");
  static String get selectGender =>
      _localizer.translate("selectGender");
  static String get selectYourGender =>
      _localizer.translate("selectYourGender");
  static String get emailAddress =>
      _localizer.translate("emailAddress");
  static String get emailAddressDescription =>
      _localizer.translate("emailAddressDescription");
  static String get emailAddressHint =>
      _localizer.translate("emailAddressHint");
  static String get verifyYourEmail =>
      _localizer.translate("verifyYourEmail");
  static String get continueWith =>
      _localizer.translate("continueWith");
  static String get createPasswordTitle =>
      _localizer.translate("createPasswordTitle");
  static String get createPasswordDescription =>
      _localizer.translate("createPasswordDescription");
  static String get createPassword =>
      _localizer.translate("createPassword");
  static String get emailVerificationTitle =>
      _localizer.translate("emailVerificationTitle");
  static String get emailVerificationDescription =>
      _localizer.translate("emailVerificationDescription");
  static String get alreadyHaveAnAccount =>
      _localizer.translate("alreadyHaveAnAccount");
  static String get welcomeBack =>
      _localizer.translate("welcomeBack");
  static String get niceToMeetYou =>
      _localizer.translate("niceToMeetYou");
  static String get whatShallWeCallYou =>
      _localizer.translate("whatShallWeCallYou");
  static String get submit =>
      _localizer.translate("submit");
  static String get updatePasswordError1 => _localizer.translate("updatePasswordError1");
  static String get updatePasswordError2 => _localizer.translate("updatePasswordError2");
  static String get updatePasswordError3 => _localizer.translate("updatePasswordError3");
  static String get updatePasswordError4 => _localizer.translate("updatePasswordError4");
  static String get updatePasswordError5 => _localizer.translate("updatePasswordError5");
  static String get updatePasswordError6 => _localizer.translate("updatePasswordError6");
  static String get maximumPasswordError => _localizer.translate("maximumPasswordError");
  static String get newPassword => _localizer.translate("newPassword");
  static String get oldPassword => _localizer.translate("oldPassword");
  static String get towPasswordDontMatch => _localizer.translate("towPasswordDontMatch");
  static String get confirmPassword => _localizer.translate("confirmPassword");
  static String get failedToLoginWithApple => _localizer.translate("failedToLoginWithApple");
  static String get failedToGetUser => _localizer.translate("failedToGetUser");
  static String get failedToLoginWithFacebook => _localizer.translate("failedToLoginWithFacebook");
  static String get failedToLoginWithGoogle => _localizer.translate("failedToLoginWithGoogle");
  static String get invalidProviderIdError => _localizer.translate("invalidProviderIdError");
  static String get userName => _localizer.translate("userName");
  static String get minimumUserCharacters => _localizer.translate("minimumUserCharacters");
  static String get usernameEmptyError => _localizer.translate("usernameEmptyError");
  static String get maximumUserCharacters => _localizer.translate("maximumUserCharacters");
  static String get createUsername => _localizer.translate("createUsername");
  static String get usernameTitle => _localizer.translate("usernameTitle");
  static String get usernameDescription => _localizer.translate("usernameDescription");
  static String get notReceiveCode => _localizer.translate("notReceiveCode");
  static String get resend => _localizer.translate("resend");
  static String get enterYourPassword => _localizer.translate("enterYourPassword");
  static String get loginDescription => _localizer.translate("loginDescription");
  static String get complete => _localizer.translate("complete");
  static String get firstnameError1 => _localizer.translate("firstnameError1");
  static String get firstnameError2 => _localizer.translate("firstnameError2");
  static String get firstnameError3 => _localizer.translate("firstnameError3");
  static String get firstnameError4 => _localizer.translate("firstnameError4");
  static String get firstnameError5 => _localizer.translate("firstnameError5");
  static String get usernameError1 => _localizer.translate("usernameError1");
  static String get usernameError2 => _localizer.translate("usernameError2");
  static String get usernameError3 => _localizer.translate("usernameError3");
  static String get usernameError4 => _localizer.translate("usernameError4");
  static String get usernameNumberError => _localizer.translate("usernameNumberError");
  static String get updatePasswordSuccess => _localizer.translate("updatePasswordSuccess");
  static String get congratulations => _localizer.translate("congratulations");
  static String get biometricAuthMessage => _localizer.translate("biometricAuthMessage");
  static String get biometricAuthentication => _localizer.translate("biometricAuthentication");
  static String get enableBiometricTitle => _localizer.translate("enableBiometricTitle");
  static String get youCanTurnBiometric => _localizer.translate("youCanTurnBiometric");
  static String get enableBiometric => _localizer.translate("enableBiometric");
  static String get skipNow => _localizer.translate("skipNow");
  static String get closeBiometricAuthenticationApp => _localizer.translate("closeBiometricAuthenticationApp");
  static String get or => _localizer.translate("or");
  static String get continueWithApple => _localizer.translate("continueWithApple");
  static String get continueWithGoogle => _localizer.translate("continueWithGoogle");
  static String get userCancelSocialLogin => _localizer.translate("userCancelSocialLogin");
  static String get confirmPasswordValidation => _localizer.translate("confirmPasswordValidation");
  static String get changePasswordSuccess => _localizer.translate("changePasswordSuccess");

  static String get emailExists => _localizer.translate("emailExists");

  static String get mergeAccountMessage =>
      _localizer.translate("mergeAccountMessage");

  static String get nameIsRequired => _localizer.translate("nameIsRequired");
  static String get inValidName => _localizer.translate("inValidName");
  static String get nameLengthError => _localizer.translate("nameLengthError");


  static String get google => _localizer.translate("google");

  static String get apple => _localizer.translate("apple");

  static String get facebook => _localizer.translate("facebook");

  static String get twitter => _localizer.translate("twitter");
  static String get logIn => _localizer.translate("logIn");
  static String get resetPassword => _localizer.translate("resetPassword");
  static String get resetPasswordDescription => _localizer.translate("resetPasswordDescription");
  static String get sendVerificationCode => _localizer.translate("sendVerificationCode");
  static String get continueWithEmail => _localizer.translate("continueWithEmail");
  static String get save => _localizer.translate("save");
  static String get verify => _localizer.translate("verify");
  static String get getStarted => _localizer.translate("getStarted");
  static String get biometricHint => _localizer.translate("biometricHint");
  static String get enableFingerprint => _localizer.translate("enableFingerprint");
  static String get emailEmptyError => _localizer.translate("emailEmptyError");
  static String get emailCaseSensitiveError => _localizer.translate("emailCaseSensitiveError");
  static String get passwordNotMatch => _localizer.translate("passwordNotMatch");
  static String get resendCodeHint => _localizer.translate("resendCodeHint");
  static String get errorPasswordEmpty => _localizer.translate("errorPasswordEmpty");
  static String get errorPassword => _localizer.translate("errorPassword");
  static String get errorEmailEmpty => _localizer.translate("errorEmailEmpty");
  static String get emailHasSpace => _localizer.translate("emailHasSpace");
  static String get errorEmailCapitalCharacters => _localizer.translate("errorEmailCapitalCharacters");
  static String get withWord => _localizer.translate("withWord");
  static String get socialEmailDescription => _localizer.translate("socialEmailDescription");
  static String get notYou => _localizer.translate("notYou");
  static String get changeEmail => _localizer.translate("changeEmail");
  static String get signUpDescription => _localizer.translate("signUpDescription");
  static String get helloThere => _localizer.translate("helloThere");
  static String get biometricPageComponent1 => _localizer.translate("biometricPageComponent1");
  static String get biometricPageComponent2 => _localizer.translate("biometricPageComponent2");
  static String get biometricPageComponent3 => _localizer.translate("biometricPageComponent3");
  static String get uploadPicture => _localizer.translate("uploadPicture");
  static String get uploadPictureDescription => _localizer.translate("uploadPictureDescription");



}
