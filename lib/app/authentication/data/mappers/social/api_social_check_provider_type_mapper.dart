
import 'package:starter/common/domain/models/token.dart';
import 'package:starter/common/utils/extensions/string.dart';
import 'package:starter/data/preferences/models/cached_user_data.dart';

import '../../../domain/models/social/check_provider_status/social_check_provider_status_result.dart';
import '../../../domain/models/social/check_provider_status/social_register_response_required_action.dart';
import '../../models/social/check_provider_status/api_check_social_provider_status_result.dart';

extension ConvertApiSocialCheckProviderStatusResultToSocialCheckProviderStatusResult
    on CheckSocialProviderStatusData {
  SocialCheckProviderStatusResult map() {
    return SocialCheckProviderStatusResult(
        registerResponseType: actionRequired
                .toString()
                .toEnum(SocialProviderStatusRequiredActionEnum.values),
        userData: CachedUserData(
            id: user?.id ?? '', token: Token(user?.token ?? '', false)));
  }
}