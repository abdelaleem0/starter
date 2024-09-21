import 'package:starter/common/base/async.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import 'package:equatable/equatable.dart';


class SocialMergeState extends Equatable {
  const SocialMergeState(
      this.mergeState,
      this.errorMessage,
      );

  final Async<AppUserModel> mergeState;
  final String? errorMessage;

  const SocialMergeState.initial() : this(const Async.initial(), null);

  SocialMergeState reduce({Async<AppUserModel>? mergeState, String? errorMessage}) {
    return SocialMergeState(mergeState ?? this.mergeState, errorMessage);
  }

  @override
  List<Object?> get props => [mergeState, errorMessage];
}