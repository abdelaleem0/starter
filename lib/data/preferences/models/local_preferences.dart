import 'package:starter/common/domain/models/user_local_preferences.dart';

class LocalPreferences {
  LocalPreferences();

  factory LocalPreferences.fromDomain(UserLocalPreferences preferences) {
    return LocalPreferences();
  }

  UserLocalPreferences map() {
    return UserLocalPreferences();
  }
}
