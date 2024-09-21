import 'package:starter/common/base/async.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/models/social/check_provider_status/social_register_response_required_action.dart';

class SocialEmailPageState extends Equatable {
  const SocialEmailPageState(
    this.checkStatus,
    this.errorMessage,
  );

  final Async<SocialProviderStatusRequiredActionEnum> checkStatus;

  final String? errorMessage;

  const SocialEmailPageState.initial() : this(const Async.initial(), null);

  SocialEmailPageState reduce(
      {Async<SocialProviderStatusRequiredActionEnum>? checkStatus,
      String? errorMessage}) {
    return SocialEmailPageState(checkStatus ?? this.checkStatus, errorMessage);
  }

  @override
  List<Object?> get props => [checkStatus, errorMessage];
}
