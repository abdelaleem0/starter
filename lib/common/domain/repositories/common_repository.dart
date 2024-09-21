import 'package:starter/common/domain/inputs/filter_intention_reminder_input.dart';
import 'package:starter/common/domain/inputs/path_view_enum.dart';
import 'package:starter/common/domain/inputs/system_action_tracker_input.dart';

abstract class CommonRepository {
  Future<void> updateFcmToken(String fcmToken);
  Future<void> logout();
  Future<void> deleteAccount();
  Future<void> downloadPdf(String sketchIdentifier , String id);
  Future<void> downloadImage(String sketchIdentifier , String id);
  Future<String> updateProfilePicture(String? profilePicture);
  Future<void> increaseSharesCount(SystemActionTrackerInput input);
  Future<void> increasePathViews(PathViewEnum pathViewEnum);
}
