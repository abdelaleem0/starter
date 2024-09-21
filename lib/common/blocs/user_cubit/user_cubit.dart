import 'package:starter/app/authentication/domain/use_case/is_user_authenticated_use_case.dart';
import 'package:starter/common/base/async.dart';
import 'package:starter/common/domain/exceptions/status_codes.dart';
import 'package:starter/common/domain/models/token.dart';
import 'package:starter/common/domain/use_cases/cached_user_data/get_cached_user_data_use_case.dart';
import 'package:starter/common/utils/bloc_utils.dart';
import 'package:starter/di/app_injector.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  late final GetCachedUserDataUseCase _getCachedUserDataUseCase;
  late UserAuthenticatedUseCase _isAuthenticatedUseCase;

  static UserCubit of(BuildContext context) => BlocProvider.of<UserCubit>(context);
  UserCubit() : super(const UserState.initial()) {
    _getCachedUserDataUseCase = injector();
    _isAuthenticatedUseCase = injector();
  }

  Future<void> initializeUserData() async {
    emit(state.reduce(const Async.loading()));
    await collect(task: () async {
      // final user = await _getCachedUserDataUseCase.execute();
      // AppUserModel userModel = AppUserModel(
      //   token: user.token,
      //   firstName: user.firstName,
      //   username: user.username,
      //   id: user.id,
      //   email: data.email,
      //   isComplete: data.isComplete,
      //   isFirstRegistration: data.isFirstRegistration,
      //   transaction: data.transaction,
      //   profilePicture: data.profilePicture,
      //   hasPassword: data.hasPassword,
      //     allowedUserFeatures: data.allowedUserFeatures,
      //   hasNotOpenedNotification: data.hasNotOpenedNotification,
      //
      //   // homeModel: null
      // );
      emit(state.reduce(Async.successWithoutData()));
    }, onError: (errorMessage) {
      emit(state.reduce(Async.failure(errorMessage)));
    }, catchError: (exception) {
      if (exception.statusCode == StatusCodes.unauthorizedCode) {
        emit(state.reduce(const Async.initial(),
            reAuthenticateState: const Async.successWithoutData()));
      }
    });
  }

  setAppUserModel(AppUserModel appUserModel) {
    emit(state.reduce(Async.success(appUserModel)));
  }

  Future<bool> getToken() async {
    return await _isAuthenticatedUseCase.execute();
  }

  void setUserName(String firstName, String username) {
    emit(state.reduce(Async.success(state.userData.data
            ?.copyWith(firstName: firstName, username: username) ??
         AppUserModel.initial()
            .copyWith(firstName: firstName, username: username))));
  }

  void updateFirstName(String firstName){
    emit(state.reduce(Async.success(state.userData.data
        ?.copyWith(firstName: firstName)??
         AppUserModel.initial().copyWith(firstName: firstName)
    )));
  }
  void updateUserName(String userName){
    emit(state.reduce(Async.success(state.userData.data
        ?.copyWith(username: userName)??
         AppUserModel.initial().copyWith(username: userName)
    )));
  }

  updateEmail(String email) {
    emit(state.reduce(Async.success(
        state.userData.data?.copyWith(email: email) ??
             AppUserModel.initial().copyWith(email: email))));
  }

  updateProfilePicture(String profilePicture) {
    emit(state.reduce(Async.success(
        state.userData.data?.copyWith(profilePicture: profilePicture) ??
             AppUserModel.initial().copyWith(profilePicture: profilePicture))));
  }

  updateTransaction(Transaction transaction) {
    emit(state.reduce(Async.success(
        state.userData.data?.copyWith(transaction: transaction) ??
             AppUserModel.initial().copyWith(transaction: transaction))));
  }

  updateBasicProfileInformation({String? firstName, String? username}) {
    emit(state.reduce(Async.success(state.userData.data?.copyWith(
          firstName: firstName,
          username: username,
        ) ??
         AppUserModel.initial()
            .copyWith(firstName: firstName, username: username))));
  }



  void resetUserCubit() {
    emit(state.reduce(const Async.initial()));
  }



  void modifyNotificationIndicatorSeen() {
    bool currentState = state.userData.data?.hasNotOpenedNotification ?? false;
    if (currentState) {
      emit(state.reduce(Async.success(state.userData.data
              ?.copyWith(hasNotOpenedNotification: false) ??
          AppUserModel.initial().copyWith(hasNotOpenedNotification: false))));
    }
  }
}
