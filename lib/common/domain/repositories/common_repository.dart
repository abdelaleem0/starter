
abstract class CommonRepository {
  Future<void> updateFcmToken(String fcmToken);
  Future<void> logout();
  Future<void> deleteAccount();
  Future<void> downloadPdf(String sketchIdentifier , String id);
  Future<void> downloadImage(String sketchIdentifier , String id);
  Future<String> updateProfilePicture(String? profilePicture);
}
