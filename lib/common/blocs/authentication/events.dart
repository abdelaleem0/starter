
import 'package:equatable/equatable.dart';

/// Events are:
/// 1- AppStarted
/// 2- Authenticated
/// 3- LoggedOut
/// 4- WalkthroughDone
/// 5- AuthRestart

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AppStartedEvent extends AuthenticationEvent {}


class AppStartBiometricEvent extends AuthenticationEvent{

}
class AppRetryBiometricEvent extends AuthenticationEvent{

}
class AppEnableBiometricEvent extends AuthenticationEvent{

}
class IsFirstRegistrationEvent extends AuthenticationEvent{

}

class AuthenticatedEvent extends AuthenticationEvent {

}
class AuthFirstNameEvent extends AuthenticationEvent{
  final bool checkLogout;
  const AuthFirstNameEvent({this.checkLogout = false});
}
class AuthUserEmailEvent extends AuthenticationEvent{

}
class LoggedOutEvent extends AuthenticationEvent {}

class DeleteAccountEvent extends AuthenticationEvent {}

class AuthRestartEvent extends AuthenticationEvent {}