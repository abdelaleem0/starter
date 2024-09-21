// ignore: constant_identifier_names
import 'package:starter/app/authentication/domain/models/social/social_provider_type.dart';

enum ApiSocialProviderTypeEnum { GOOGLE, APPLE }

class ApiSocialProviderTypeMapper {
  static ApiSocialProviderTypeEnum map(SocialProviderTypeEnum socialProviderTypeEnum){
    if(socialProviderTypeEnum == SocialProviderTypeEnum.apple){
      return ApiSocialProviderTypeEnum.APPLE;
    }else{
      return ApiSocialProviderTypeEnum.GOOGLE;
    }
  }
}