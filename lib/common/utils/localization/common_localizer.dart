
import 'package:starter/common/utils/localization/common_localization.dart';
import 'package:starter/di/app_injector.dart';
import 'package:starter/di/localizations_container.dart';

class CommonLocalizer {

  CommonLocalizer._();
  static CommonLocalization get _localizer =>
      injector.get<LocalizationsContainer>().getLocalizations();

  static String get start => _localizer.translate("start");
  static String get paths => _localizer.translate("paths");
  static String get pathsDescription => _localizer.translate("pathsDescription");
  static String get planerPath => _localizer.translate("planerPath");
  static String get planerPathDes => _localizer.translate("planerPathDes");
  static String get goalPath => _localizer.translate("goalPath");
  static String get goalPathDes => _localizer.translate("goalPathDes");
  static String get wellPath => _localizer.translate("wellPath");
  static String get wellDes => _localizer.translate("wellDes");
  static String get roadMapPath => _localizer.translate("roadMapPath");
  static String get roadMapDes => _localizer.translate("roadMapDes");


  static String get tryAgain => _localizer.translate("tryAgain");
  static String get networkError => "Network Error";
  static String get goBack => "Go back";
  static String get screen1Desc => _localizer.translate("screen1Desc");
  static String get screen2Desc => _localizer.translate("screen2Desc");
  static String get screen3Desc => _localizer.translate("screen3Desc");

  static String get next => _localizer.translate("next");
  static String get skip => _localizer.translate("skip");
  static String get login => _localizer.translate("consultant_login");

  static String get serverError => _localizer.translate("serverError");
  static String get unexpectedError => _localizer.translate("unexpectedError");
  static String get somethingWentWrong => _localizer.translate("somethingWentWrong");
  static String get maxNumOfImages => _localizer.translate("maxNumOfImages");
  static String get noValuesError => _localizer.translate("noValuesError");
  static String get previewImage => _localizer.translate("previewImage");
  static String get decodeError => _localizer.translate("decodeError");
  static String get decodeWatermarkError => _localizer.translate("decodeWatermarkError");
  static String get hide => _localizer.translate("hide");
  static String get messageSentSuccessfully => _localizer.translate("messageSentSuccessfully");
  static String get pleaseSelectReason => _localizer.translate("pleaseSelectReason");
  static String get pleaseEnterYourName => _localizer.translate("pleaseEnterYourName");
  static String get subject => _localizer.translate("subject");
  static String get inquiryOrComplaint => _localizer.translate("inquiryOrComplaint");
  static String get pleaseWriteYourMessage => _localizer.translate("pleaseWriteYourMessage");
  static String get send => _localizer.translate("send");

  static String get buyerComplaint => _localizer.translate("buyerComplaint");
  static String get storeComplaint => _localizer.translate("storeComplaint");
  static String get productComplaint => _localizer.translate("productComplaint");
  static String get other => _localizer.translate("other");

  static String get complaint => _localizer.translate("complaint");
  static String get technicalIssue => _localizer.translate("technicalIssue");
  static String get suggestion => _localizer.translate("suggestion");
  static String get forBusiness => _localizer.translate("forBusiness");
  static String get refund => _localizer.translate("refund");
  static String get aboutUs => _localizer.translate("aboutUs");
  static String get yourTransactionIsSuccessful => _localizer.translate("yourTransactionIsSuccessful");
  static String get yourTransactionFailed => _localizer.translate("yourTransactionFailed");
  static String get compressionFailed => _localizer.translate("compressionFailed");
  static String get preview => _localizer.translate("preview");
  static String get remove => _localizer.translate("remove");
  static String get gallery => _localizer.translate("gallery");
  static String get camera => _localizer.translate("camera");
  static String get attachVideoHere => _localizer.translate("attachVideoHere");
  static String get save => _localizer.translate("save");

  static String get sinceDate => _localizer.translate("sinceDate");
  static String get justNow => _localizer.translate("justNow");
  static String get day => _localizer.translate("day");
  static String get week => _localizer.translate("week");
  static String get minute => _localizer.translate("minute");
  static String get hour => _localizer.translate("hour");
  static String get contactUs => _localizer.translate("contactUs");
  static String get username => _localizer.translate("username");
  static String get phoneNumber => _localizer.translate("phoneNumber");
  static String get emailOptional => _localizer.translate("emailOptional");
  static String get emailError => _localizer.translate("emailError");
  static String get yesImSure => _localizer.translate("yesImSure");
  static String get no => _localizer.translate("no");
  static String get noImageFound => _localizer.translate("noImageFound");
  static String get paymentMethods => _localizer.translate("paymentMethods");
  static String get otherPaymentMethods => _localizer.translate("otherPaymentMethods");
  static String get payCommissionDescription => _localizer.translate("payCommissionDescription");
  static String get commission => _localizer.translate("commission");
  static String get payNow => _localizer.translate("payNow");
  static String get iBan => _localizer.translate("iBan");
  static String get accountNumber => _localizer.translate("accountNumber");
  static String get usageAgreement => _localizer.translate("usageAgreement");

  // select consultant Page
  static String get searchForConsultant => _localizer.translate("searchForConsultant");
  static String get selectYourConsultant => _localizer.translate("selectYourConsultant");
  static String get share => _localizer.translate("share");

  static String get sorryNoResultFound => _localizer.translate("sorryNoResultFound");
  static String get continueText => _localizer.translate("continue");
  static String get accept => _localizer.translate("accept");
  static String get cancel => _localizer.translate("cancel");
  static String get passwordNotMatchError =>
      _localizer.translate("passwordNotMatchError");
  static String get ok =>
      _localizer.translate("ok");
  static String get noInternet => _localizer.translate("noInternet");
  static String get retry => _localizer.translate("retry");
  static String get noMoreChallenges => _localizer.translate("noMoreChallenges");
  static String get imageIsNotValid => _localizer.translate("imageIsNotValid");
  static String get couldNotLaunch => _localizer.translate("couldNotLaunch");
  static String get attachments => _localizer.translate("attachments");
  static String get mediaImage => _localizer.translate("mediaImage");

  static String get readMore => _localizer.translate("readMore");
  static String get leaveAReply => _localizer.translate("leaveAReply");
  static String get second => _localizer.translate("second");

  // PrettyDateExtensions

  static String get month => _localizer.translate("month");

  static String get year => _localizer.translate("year");

  static String get h => _localizer.translate("h");

  static String get m => _localizer.translate("m");

  static String get sec => _localizer.translate("sec");

  static String get days => _localizer.translate("days");

  static String get months => _localizer.translate("months");
  static String get years => _localizer.translate("years");
  static String get back => _localizer.translate("back");
  static String get yes => _localizer.translate("yes");
  static String get choosePhotosFromGallery => _localizer.translate("choosePhotosFromGallery");
  static String get takePhoto => _localizer.translate("takePhoto");
  static String get chooseVideoFromStorage => _localizer.translate("chooseVideoFromStorage");
  static String get takeVideo => _localizer.translate("takeVideo");
  static String get uploadFile => _localizer.translate("uploadFile");
  static String get confirm => _localizer.translate("confirm");
  static String get goToHome => _localizer.translate("goToHome");
  static String get createSketch => _localizer.translate("createSketch");
  static String get sketchPreparation => _localizer.translate("sketchPreparation");
  static String get downloadText => _localizer.translate("downloadText");
  static String get downloadAsText => _localizer.translate("downloadAsText");
  static String get downloadedSuccessfully => _localizer.translate("downloadedSuccessfully");
  static String get shareText => _localizer.translate("shareText");
  static String get complete => _localizer.translate("complete");
  static String get commonEmptyValidation => _localizer.translate("commonEmptyValidation");
  static String get twoCharactersValidation => _localizer.translate("twoCharactersValidation");
  static String get maxCharactersValidation => _localizer.translate("maxCharactersValidation");
  static String get allQuestionsNotEmpty => _localizer.translate("allQuestionsNotEmpty");
  static String get actionsValidation => _localizer.translate("actionsValidation");
  static String get congratulationsGoalDescription => _localizer.translate("congratulationsGoalDescription");
  static String get congratulationsPlanerDescription => _localizer.translate("congratulationsPlanerDescription");
  static String get congratulationsCreateInspireDescription => _localizer.translate("congratulationsCreateInspireDescription");
  static String get congratulations => _localizer.translate("congratulations");
  static String get checkIn => _localizer.translate("checkIn");
  static String get addPicture => _localizer.translate("addPicture");
  static String get sendMessage => _localizer.translate("sendMessage");
  static String get readyToMaser => _localizer.translate("readyToMaser");
  static String get readyToMaserGoal => _localizer.translate("readyToMaserGoal");
  static String get deletedAccount => _localizer.translate("deletedAccount");


}