import 'package:starter/common/utils/extensions/string.dart';

class Constants {
  static const packageName = "com.AjmalApp";
  static const isProductionInDebug = false;
  static const isProduction = true  ? true : isProductionInDebug;

  static const String endpoint = isProduction
      ? 'https://api.ajmal.app/graphql'
      : 'http://75.119.134.216:85/graphql';

  static const String subscriptionLink = isProduction
      ? 'https://api.ajmal.app/graphql'
      : 'http://75.119.134.216:85/graphql';

  static const String baseUrl = isProduction
      ? 'https://api.ajmal.app/'
      : 'http://75.119.134.216:85/';

  static String concatWithBaseUrl(String? url){
    if(url == null) return "";

    if(url.isNetwork){
      return url;
    }

    return baseUrl + url;
  }
}

class SketchIdentifierConstants{
  static String weeklyPlannerImage = "downloadUserWeeklyPlaner/";
  static String weeklyPlannerPdf   = "downloadUserWeeklyPlanerPdf/";

  static String weeklyPlannerCheckInImage = 'downloadUserWeeklyPlanerCheckIn/';
  static String weeklyPlannerCheckInPdf = 'downloadUserWeeklyPlanerCheckInPDF/';

  static String milestoneImage = 'downloadUserMilestone/';
  static String milestonePdf = 'downloadUserMilestonePDF/';

  static String goalImage = 'downloadUserGoal/';
  static String goalPdf = 'downloadUserGoalPdf/';

  static String goalCheckInImage = 'downloadUserGoalCheckIn/';
  static String goalCheckInPdf = 'downloadUserGoalCheckInPDF/';

  static String feelWellImage = "downloadFellWellJournal/";
  static String feelWellPdf   = "downloadFellWellJournalPDF/";

  static String relationshipRoadmapImage = "downloadUserRelationshipRoadmap/";
  static String relationshipRoadmapPdf   = "downloadUserRelationshipPdf/";

  static String relationshipCheckInImage = 'downloadUserRelationshipCheckIn/';
  static String relationshipCheckInPdf = 'downloadUserRelationshipCheckInPDF/';

}

class DoesNotExistMessageConstants {
  static String event = "Event does not exist";
  static String challenge = "Challenge does not exist";
  static String postNotFound = "Post not found";
  static String article = "Article not found";
}