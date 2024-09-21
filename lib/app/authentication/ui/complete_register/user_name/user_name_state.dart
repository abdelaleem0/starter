import 'package:starter/common/base/async.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import 'package:equatable/equatable.dart';

class UserNameState extends Equatable {
  final Async<void> isUserNameExists;
  final Async<String>? updateUserProfilePictureState;
  final String? errorMessage;

  const UserNameState(
    this.isUserNameExists,
    this.updateUserProfilePictureState,
    this.errorMessage,
  );

  const UserNameState.initial()
      : this(
          const Async.initial(),
          const Async.initial(),
          null,
        );

  UserNameState reduce({
    Async<AppUserModel>? completeRegisterState,
    Async<void>? isUserNameExists,
    Async<String>? updateUserProfilePictureState,
    String? errorMessage,
  }) {
    return UserNameState(
      isUserNameExists ?? this.isUserNameExists,
      updateUserProfilePictureState?? this.updateUserProfilePictureState,
      errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        errorMessage,
        updateUserProfilePictureState,
        isUserNameExists
      ];
}
