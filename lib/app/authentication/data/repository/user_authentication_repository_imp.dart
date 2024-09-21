import 'dart:developer';
import 'package:starter/app/authentication/data/mappers/api_user_data_mapper.dart';
import 'package:starter/app/authentication/data/models/complete_register/api_complete_register_input.dart';
import 'package:starter/app/authentication/data/models/complete_register/api_complete_register_result.dart';
import 'package:starter/app/authentication/data/models/email_exists/api_email_exists.dart';
import 'package:starter/app/authentication/data/models/is_username_exists/api_is_username_exists_result.dart';
import 'package:starter/app/authentication/data/models/register/api_register_input.dart';
import 'package:starter/app/authentication/data/models/register/api_register_result.dart';
import 'package:starter/app/authentication/data/models/resend_email_verification_code_input/api_resend_email_verification_code_input.dart';
import 'package:starter/app/authentication/data/models/resend_email_verification_code_input/api_resend_email_verification_code_result.dart';
import 'package:starter/app/authentication/data/models/verify_email/api_verify_email_user.dart';
import 'package:starter/app/authentication/data/models/verify_email/api_verify_email_user_result.dart';
import 'package:starter/app/authentication/data/models/verify_password/api_verify_password_input.dart';
import 'package:starter/app/authentication/data/models/verify_password/api_verify_password_result.dart';
import 'package:starter/app/authentication/domain/models/inputs/complete_register_input.dart';
import 'package:starter/app/authentication/domain/models/inputs/login_details_input.dart';
import 'package:starter/app/authentication/domain/models/inputs/login_input.dart';
import 'package:starter/app/authentication/domain/models/inputs/register_input.dart';
import 'package:starter/app/authentication/domain/models/inputs/update_password_input.dart';
import 'package:starter/app/authentication/domain/models/otp_verification/otp_verification/otp_verification_input.dart';
import 'package:starter/app/authentication/domain/models/otp_verification/resond_otp/resend_verification_otp_input.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import 'package:starter/data/preferences/models/cached_user_data.dart';
import 'package:starter/data/preferences/preferences_helper.dart';
import 'package:starter/data/utils/graphql_extensions.dart';
import 'package:starter/app/authentication/data/graphql/authentication_requests.dart';
import 'package:starter/app/authentication/data/models/forget_password/api_forget_password_result.dart';
import 'package:starter/app/authentication/data/models/login/api_login_input.dart';
import 'package:starter/app/authentication/data/models/login/api_login_result.dart';
import 'package:starter/app/authentication/data/models/update_password/api_update_password_result.dart';
import 'package:starter/app/authentication/domain/repositories/user_authentication_repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:starter/common/domain/exceptions/exceptions.dart';
import 'package:starter/common/domain/exceptions/status_codes.dart';
import 'package:starter/common/domain/models/token.dart';

class UserAuthenticationRepositoryImp implements UserAuthenticationRepository {
  final PreferencesHelper _preferencesHelper;
  final GraphQLClient _graphQLClient;

  UserAuthenticationRepositoryImp(this._preferencesHelper, this._graphQLClient);

  @override
  Future<void> cacheUserData(CachedUserData userData) async {
    return await _preferencesHelper.setUserData(userData);
  }

  @override
  Future<void> deleteUserData() async {
    return await _preferencesHelper.deleteUserData();
  }

  @override
  Future<AppUserModel> login(
      LoginInput input, LoginDetailsInput loginDetailsInput) async {
    final result = await _graphQLClient.perform(
        mutation: loginMutation,
        variables: {
          "input": ApiLoginInput.fromLoginInput(input).toJsonWithoutNulls()
        });
    if (result.hasException || result.data == null) {
      throw const ServerException();
    } else {
      final request = ApiLoginResult.fromJson(result.data!).registerOrlogin;
      final data = request?.data;
      if (request?.code == StatusCodes.success && data != null) {
        return data.mapToAppUser();
      } else {
        throw ApiRequestException(
          request?.code ?? StatusCodes.unknown,
          request?.message ?? "",
        );
      }
    }
  }

  @override
  Future<void> updateToken(Token token) async {
    return await _preferencesHelper.setToken(token);
  }

  @override
  Future<CachedUserData> getCachedUserData() async {
    return await _preferencesHelper.getUserData();
  }

  @override
  Future<bool> forgetPassword(String email) async {
    final result = await _graphQLClient.perform(
      mutation: forgetPasswordMutation,
      variables: {
        "input": {"email": email},
      },
    );
    if (result.hasException || result.data == null) {
      throw const ServerException();
    } else {
      final request =
          ApiForgetPasswordResult.fromJson(result.data!).forgetPassword;
      final data = request?.data;
      if (request?.code == StatusCodes.success && data != null) {
        return data;
      } else {
        throw ApiRequestException(
            request?.code ?? StatusCodes.unknown, request?.message ?? "");
      }
    }
  }

  @override
  Future<({bool verifyState, AppUserModel? appUserModel})>
      registerOtpVerification(OtpVerificationInput input) async {
    final result = await _graphQLClient
        .perform(mutation: verifyByEmailMutation, variables: {
      "input": ApiVerifyEmailUserInput.fromVerifyCodeInput(
          email: input.email, verificationCode: input.verificationCode),
    });
    if (result.hasException) {
      log(result.data.toString());
      log(result.exception.toString());
      throw const ServerException();
    } else {
      final request =
          ApiVerifyEmailUserData.fromJson(result.data!).verifyUserByEmail;
      final data = request?.data;
      if (request?.code == StatusCodes.success && data != null) {
        return (verifyState: true, appUserModel: data.mapToAppUser());
      } else {
        throw ApiRequestException(
            request?.code ?? StatusCodes.unknown, request?.message ?? "");
      }
    }
  }

  @override
  Future<String> updatePassword(UpdatePasswordInput updatePasswordInput) async {
    final result = await _graphQLClient.perform(
      mutation: updatePasswordMutation,
      variables: {
        "input": {
          "email": updatePasswordInput.email,
          "newPassword": updatePasswordInput.newPassword,
          "code": updatePasswordInput.code,
        },
      },
    );
    if (result.hasException || result.data == null) {
      throw const ServerException();
    } else {
      final request =
          ApiUpdatePasswordResult.fromJson(result.data!).resetPassword;
      final data = request?.data;
      if (request?.code == StatusCodes.success && data != null) {
        return data.verifiedEmail ?? "";
      } else {
        throw ApiRequestException(
            request?.code ?? StatusCodes.unknown, request?.message ?? "");
      }
    }
  }

  @override
  Future<void> userRegister(
      RegisterInput registerInput, LoginDetailsInput loginDetailsInput) async {
    final result = await _graphQLClient
        .perform(mutation: userRegisterMutation, variables: {
      "registerInput":
          ApiRegisterInput.fromRegisterInput(registerInput, loginDetailsInput)
              .toJsonWithoutNulls(),
    });
    if (result.hasException || result.data == null) {
      throw const ServerException();
    } else {
      final request = ApiRegisterResult.fromJson(result.data!).completeRegister;
      if (request?.code == StatusCodes.success) {
        return;
      } else {
        throw ApiRequestException(
            request?.code ?? StatusCodes.unknown, request?.message ?? "");
      }
    }
  }

  @override
  Future<bool> isEmailExists(String email) async {
    final result =
        await _graphQLClient.fetch(query: doesEmailExistsQuery, variables: {
      "input": {"email": email}
    });
    if (result.hasException || result.data == null) {
      throw const ServerException();
    } else {
      final request =
          ApiEmailExistsData.fromJson(result.data!).doesVerifiedEmailExist;
      if (request?.code == StatusCodes.success) {
        return request?.data ?? false;
      } else {
        throw ApiRequestException(
            request?.code ?? StatusCodes.unknown, request?.message ?? "");
      }
    }
  }

  @override
  Future<bool> resendOtp(ResendOtpInput input) async {
    final result = await _graphQLClient
        .perform(mutation: resendEmailVerificationCodeMutation, variables: {
      "input": ApiResendEmailVerificationCodeInput
          .fromApiResendEmailVerificationCodeInput(input),
    });
    if (result.hasException) {
      throw const ServerException();
    } else {
      final request = ApiResendEmailVerificationCode.fromJson(result.data!)
          .resendEmailVerificationCode;
      final data = request?.data;
      if (request?.code == StatusCodes.success && data != null) {
        return data;
      } else {
        throw ApiRequestException(
            request?.code ?? StatusCodes.unknown, request?.message ?? "");
      }
    }
  }


  @override
  Future<AppUserModel> completeRegister(
      CompleteRegisterInput completeRegisterInput) async {
    final result = await _graphQLClient.perform(
      mutation: completeRegisterMutation,
      variables: {
        "input": ApiCompleteRegisterInput.fromCompleteRegisterInput(
                completeRegisterInput)
            .toJson()
      },
    );
    if (result.hasException || result.data == null) {
      throw const ServerException();
    } else {
      final request =
          ApiCompleteRegisterResult.fromJson(result.data!).completeUserRegister;
      final data = request?.data;
      if (request?.code == StatusCodes.success && data != null) {
        return data.mapToAppUser();
      } else {
        throw ApiRequestException(
            request?.code ?? StatusCodes.unknown, request?.message ?? "");
      }
    }
  }

  @override
  Future<bool> forgetPasswordOtpVerification(OtpVerificationInput input) async {
    final result = await _graphQLClient.perform(
      mutation: verifyForgetPasswordMutation,
      variables: {
        "input": ApiVerifyPasswordInput.fromVerifyCodeInput(
                input.verificationCode, input.email)
            .toJsonWithoutNulls()
      },
    );
    if (result.hasException || result.data == null) {
      throw const ServerException();
    } else {
      final request = ApiVerifyForgotPasswordData.fromJson(result.data!)
          .verifyForgetPasswordCode;
      final data = request?.data;
      if (request?.code == StatusCodes.success && data != null) {
        return data;
      } else {
        throw ApiRequestException(
            request?.code ?? StatusCodes.unknown, request?.message ?? "");
      }
    }
  }


  @override
  Future<bool> isUserNameExists(String userName) async {
    final result = await _graphQLClient.perform(
      mutation: validateUsername,
      variables: {"username": userName},
    );
    if (result.hasException || result.data == null) {
      throw const ServerException();
    } else {
      final request =
          ApiApiIsUserExistsData.fromJson(result.data!).validateUsername;
      if (request?.code == StatusCodes.success) {
        final bool isValid = request?.data ?? false;
        return isValid;
      } else {
        throw ApiRequestException(
            request?.code ?? StatusCodes.unknown, request?.message ?? "");
      }
    }
  }
}
