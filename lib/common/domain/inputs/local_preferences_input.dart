

import 'package:starter/common/domain/models/user_local_preferences.dart';

class LocalPreferencesInput {
  LocalPreferencesInput();

  UserLocalPreferences mergeWithUserPreferences(UserLocalPreferences preferences) {
    return UserLocalPreferences();
  }
}