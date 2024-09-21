import 'package:starter/common/base/async.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import 'package:equatable/equatable.dart';

class ProfilePictureState extends Equatable {
  final Async<AppUserModel> completeRegisterState;
  final String? errorMessage;

  const ProfilePictureState(this.completeRegisterState, this.errorMessage);

  const ProfilePictureState.initial() : this(const Async.initial(), '');

  ProfilePictureState reduce({
    Async<AppUserModel>? completeRegisterState,
    String? errorMessage,
  }) {
    return ProfilePictureState(
      completeRegisterState ?? this.completeRegisterState,
      errorMessage?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [completeRegisterState, errorMessage];
}
