
class ApiUserData {
  ApiUserData({
    this.token,
    this.id,
    this.isCompletedRegister,
    this.userName,
    this.isFirstRegistration,
    this.firstName,
    this.verifiedEmail,
    this.profilePicture,
    this.hasPassword,
    this.allowedUserFeatures,
    this.notificationsSettings,
    this.hasNotOpenedNotification,
  });

  final String? token;
  final String? id;
  final bool? isCompletedRegister;
  final bool? isFirstRegistration;
  final String? verifiedEmail;
  final String? userName;
  final String? firstName;
  final String? profilePicture;
  final bool? hasPassword;
  final ApiAllowedFeatures? allowedUserFeatures;
  final ApiNotificationSetting? notificationsSettings;
  final bool? hasNotOpenedNotification;

  factory ApiUserData.fromJson(Map<String, dynamic> json) => ApiUserData(
      token: json["token"],
      id: json["id"],
      isCompletedRegister: json["isCompletedRegister"],
      userName: json["userName"],
      isFirstRegistration: json["isFirstRegistration"],
      firstName: json["firstName"],
      verifiedEmail: json["verifiedEmail"],
      profilePicture: json["profilePicture"],
      hasPassword: json["hasPassword"],
    allowedUserFeatures: json["allowedUserFeatures"] != null ? ApiAllowedFeatures.fromJson(json["allowedUserFeatures"]) : null,
      notificationsSettings: json["notificationsSettings"] != null ? ApiNotificationSetting.fromJson(json["notificationsSettings"]) : null,
      hasNotOpenedNotification :json["hasNotOpenedNotification"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "id": id,
    "isCompletedRegister": isCompletedRegister,
    "userName": userName,
    "isFirstRegistration": isFirstRegistration,
    "firstName": firstName,
    "verifiedEmail": verifiedEmail,
    "profilePicture": profilePicture,
    "hasPassword": hasPassword,
    "allowedUserFeatures": allowedUserFeatures,
    "hasNotOpenedNotification": hasNotOpenedNotification
  };
}

class ApiAllowedFeatures{
  final bool? createWeeklyPlan;
  final bool? accessMilestone;
  final bool? createGoal;
  final bool? createRelationshipWithAllah;
  final bool? createRelationshipWithOthers;
  final bool? createRelationshipWithMyself;
  final bool? accessFeelWell;
  final bool? accessEvents;
  final bool? attendEvent;
  final bool? accessInspire;
  final bool? createInspirePost;
  final bool? participateChallenges;
  final bool? canAccessFreeTrail;

  ApiAllowedFeatures({
    this.createWeeklyPlan,
    this.accessMilestone,
    this.createGoal,
    this.createRelationshipWithAllah,
    this.createRelationshipWithOthers,
    this.createRelationshipWithMyself,
    this.accessFeelWell,
    this.accessEvents,
    this.attendEvent,
    this.accessInspire,
    this.createInspirePost,
    this.participateChallenges,
    this.canAccessFreeTrail
  });


  factory ApiAllowedFeatures.fromJson(Map<String, dynamic> json) => ApiAllowedFeatures(
      createWeeklyPlan: json["createWeeklyPlan"],
      accessMilestone: json["accessMilestone"],
      createGoal: json["createGoal"],
      createRelationshipWithAllah: json["createRelationshipWithAllah"],
      createRelationshipWithOthers: json["createRelationshipWithOthers"],
      createRelationshipWithMyself: json["createRelationshipWithMyself"],
      accessFeelWell: json["accessFeelWell"],
      accessEvents: json["accessEvents"],
      attendEvent: json["attendEvent"],
      accessInspire: json["accessInspire"],
      createInspirePost: json["createInspirePost"],
      participateChallenges: json["participateChallenges"],
      canAccessFreeTrail: json["canAccessFreeTrail"]
  );

}
class ApiNotificationSetting{

 final bool? likes;
 final bool? comments;
 final bool? newEvents;
 final bool? newChallenges;
 final bool? mentions;
 final bool? replies;
  ApiNotificationSetting({
    this.likes,
    this.comments,
    this.newEvents,
    this.newChallenges,
    this.mentions,
    this.replies,
  });


  factory ApiNotificationSetting.fromJson(Map<String, dynamic> json) => ApiNotificationSetting(
      likes: json["likes"],
      comments: json["comments"],
      newEvents: json["newEvents"],
      newChallenges: json["newChallenges"],
      mentions: json["mentions"],
      replies: json["replies"],
  );

}