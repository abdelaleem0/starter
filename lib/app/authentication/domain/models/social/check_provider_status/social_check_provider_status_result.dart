import 'package:starter/data/preferences/models/cached_user_data.dart';
import 'package:equatable/equatable.dart';

import 'social_register_response_required_action.dart';

class SocialCheckProviderStatusResult extends Equatable {
  final SocialProviderStatusRequiredActionEnum registerResponseType;
  final CachedUserData? userData;

  const SocialCheckProviderStatusResult(
      {required this.registerResponseType, this.userData});

  @override
  List<Object?> get props => [registerResponseType, userData];
}
