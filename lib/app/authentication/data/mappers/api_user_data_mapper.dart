import 'package:starter/app/authentication/data/models/api_user_data.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import 'package:starter/common/domain/models/token.dart';
import 'package:starter/common/utils/constants.dart';

extension ConvertApiUserDataToAppUserModel on ApiUserData {

  AppUserModel mapToAppUser() {
    return AppUserModel(
        token: Token(token ?? '', isCompletedRegister ?? false),
        firstName: firstName,
        email: verifiedEmail ?? "",
        id: id,
        isComplete: isCompletedRegister ?? false,
        isFirstRegistration: isFirstRegistration ?? false,
        username: userName,
        profilePicture: profilePicture == ''
            ? ''
            : Constants.concatWithBaseUrl(profilePicture),
        hasPassword: hasPassword ?? false,
        allowedUserFeatures: allowedUserFeatures?.map(),
      hasNotOpenedNotification: hasNotOpenedNotification??false,
    );
  }
}

extension ConvertAllowedUserFeatures on ApiAllowedFeatures {
  AllowedFeatures map() {
    return AllowedFeatures(
        createWeeklyPlan: createWeeklyPlan ?? false,
        accessMilestone: accessMilestone ?? false,
        createGoal: createGoal ?? false,
        createRelationshipWithAllah: createRelationshipWithAllah ?? false,
        createRelationshipWithOthers: createRelationshipWithOthers ?? false,
        createRelationshipWithMyself: createRelationshipWithMyself ?? false,
        accessFeelWell: accessFeelWell ?? false,
        accessEvents: accessEvents ?? false,
        attendEvent: attendEvent ?? false,
        accessInspire: accessInspire ?? false,
        createInspirePost: createInspirePost ?? false,
        participateChallenges: participateChallenges ?? false,
        canAccessFreeTrail: canAccessFreeTrail ?? false
    );
  }
}


// extension ConvertNotificationSetting on ApiNotificationSetting {
//   NotificationSettingsInput map() {
//     return NotificationSettingsInput(
//       likes:likes ,
//       comments:comments ,
//       newEvents: newEvents,
//       newChallenges:newChallenges ,
//       mentions:mentions ,
//       replies:replies ,
//     );
//   }
// }

