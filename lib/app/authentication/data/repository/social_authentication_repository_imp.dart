import 'package:starter/app/authentication/data/mappers/api_user_data_mapper.dart';
import 'package:starter/app/authentication/data/mappers/social/api_social_check_provider_type_mapper.dart';
import 'package:starter/app/authentication/data/models/otp/otp_verification/api_otp_verification_input.dart';
import 'package:starter/app/authentication/data/models/social/login/api_social_login_input.dart';
import 'package:starter/app/authentication/data/models/social/login/api_social_login_result.dart';
import 'package:starter/app/authentication/data/models/social/merge/api_social_merge_result.dart';
import 'package:starter/app/authentication/data/models/social/register/api_social_register_result.dart';
import 'package:starter/app/authentication/data/models/verify_email/api_social_otp_verification_result.dart';
import 'package:starter/app/authentication/domain/models/otp_verification/otp_verification/otp_verification_input.dart';
import 'package:starter/app/authentication/domain/models/social/merge/social_merge_input.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import 'package:starter/common/domain/exceptions/exceptions.dart';
import 'package:starter/common/domain/exceptions/status_codes.dart';
import 'package:starter/common/utils/extensions/map.dart';
import 'package:starter/data/utils/graphql_extensions.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../domain/models/social/check_provider_status/social_check_provider_status_input.dart';
import '../../domain/models/social/check_provider_status/social_check_provider_status_result.dart';
import '../../domain/models/social/login/social_login_input.dart';
import '../../domain/models/social/register/social_register_input.dart';
import '../../domain/repositories/social_authentication_repository.dart';
import '../graphql/social_requests.dart';
import '../models/social/check_provider_status/api_check_social_provider_status_input.dart';
import '../models/social/check_provider_status/api_check_social_provider_status_result.dart';
import '../models/social/merge/api_social_merge_input.dart';
import '../models/social/register/api_social_register_input.dart';

class SocialAuthenticationRepositoryImp
    implements SocialAuthenticationRepository {
  final GraphQLClient _graphQLClient;

  const SocialAuthenticationRepositoryImp(this._graphQLClient);

  @override
  Future<AppUserModel> socialRegister(SocialRegisterInput input) async {
    final result = await _graphQLClient
        .perform(mutation: socialRegisterMutation, variables: {
      "input": ApiSocialRegisterInput.fromInput(input).toJson().withOutNulls,
    });
    if (result.hasException && result.data == null) {
      throw const ServerException();
    } else {
      final registerData =
          ApiSocialRegisterResult.fromJson(result.data!).socialRegister;
      if (registerData?.code == StatusCodes.success &&
          registerData?.data != null) {
        return registerData!.data!.mapToAppUser();
      } else {
        throw ApiRequestException(registerData?.code ?? StatusCodes.unknown,
            registerData?.message ?? "");
      }
    }
  }

  @override
  Future<AppUserModel?> socialLogin(SocialLogInInput input) async {
    final result = await _graphQLClient.perform(
        mutation: socialLogInMutation,
        variables: {
          "input": ApiSocialLogInInput.fromInput(input).toJson().withOutNulls
        });
    if (result.hasException && result.data == null) {
      throw const ServerException();
    } else {
      final socialLoginData =
          ApiSocialLoginResult.fromJson(result.data!).socialLogin;
      if (socialLoginData?.code == StatusCodes.success &&
          socialLoginData != null) {
        final data = socialLoginData.socialLoginData;
        if (data != null) {
          return data.mapToAppUser();
        }
        return null;
      } else {
        throw ApiRequestException(socialLoginData?.code ?? StatusCodes.unknown,
            socialLoginData?.message ?? "");
      }
    }
  }

  @override
  Future<SocialCheckProviderStatusResult> checkSocialProvider(
      SocialCheckProviderStatusInput input) async {
    final result = await _graphQLClient.fetch(
        query: checkSocialProviderQuery,
        variables: {
          "input": ApiCheckProviderStatusInput.fromInput(input).toJson().withOutNulls
        });
    if (result.hasException && result.data == null) {
      throw const ServerException();
    } else {
      final request = ApiSocialCheckProviderStatusResult.fromJson(result.data!);
      final socialLoginData = request.checkSocialProviderStatus;
      final data = socialLoginData?.data;
      if (socialLoginData?.code == StatusCodes.success && data != null) {
        return data.map();
      } else {
        throw ApiRequestException(socialLoginData?.code ?? StatusCodes.unknown,
            socialLoginData?.message ?? "");
      }
    }
  }

  @override
  Future<AppUserModel> socialMerge(SocialMergeInput input) async {
    final result = await _graphQLClient.fetch(
        query: socialMergeMutation,
        variables: {
          "input": ApiSocialMergeInput.fromInput(input).toJson().withOutNulls
        });
    if (result.hasException && result.data == null) {
      throw const ServerException();
    } else {
      final data = ApiSocialMergeResult.fromJson(result.data!).socialMerge;
      final mergeData = data?.data;
      if (data?.code == StatusCodes.success && mergeData != null) {
        return mergeData.mapToAppUser();
      } else {
        throw ApiRequestException(
            data?.code ?? StatusCodes.unknown, data?.message ?? "");
      }
    }
  }

  @override
  Future<({bool verifyState, AppUserModel? appUserModel})> verifyOtp(OtpVerificationInput input) async {
    final result = await _graphQLClient.perform(
        mutation: socialVerifyEmailMutation,
        variables: {
          "input": ApiOtpVerificationInput.fromInput(input).toJson()
        });
    if (result.hasException && result.data == null) {
      throw const ServerException();
    } else {
      final data = ApiSocialOtpVerificationResult.fromJson(result.data!)
          .verifyEmailOwnership;
      final mergeData = data?.data;
      if (data?.code == StatusCodes.success && mergeData != null) {
        return (verifyState: true,appUserModel : mergeData.mapToAppUser());
      } else {
        throw ApiRequestException(
            data?.code ?? StatusCodes.unknown, data?.message ?? "");
      }
    }
  }
}
