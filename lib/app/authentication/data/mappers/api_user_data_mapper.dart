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
      hasNotOpenedNotification: hasNotOpenedNotification ?? false,
    );
  }
}
