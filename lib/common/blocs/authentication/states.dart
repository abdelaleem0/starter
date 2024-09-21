import 'package:equatable/equatable.dart';

///States are:
///1- Uninitialized
///2- Authenticated
///3- Unauthenticated
///4- First Time
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

//--------------------------------------
class AuthAuthenticated extends AuthState {

  AuthAuthenticated();

  @override
  List<Object?> get props => [];
}

class AuthUninitialized extends AuthState {}
class AuthLoading extends AuthState {}

class AuthUnauthenticated extends AuthState {}
class AuthFirstName extends AuthState{
  final bool checkLogout;

  AuthFirstName({this.checkLogout = false});

}
class AuthUserEmail extends AuthState{

}
class AuthFailure extends AuthState {
  final String errorMessage;

  AuthFailure(this.errorMessage);
}
class AuthEnabledBiometricAuthenticated extends AuthState{

}

class AuthStartBiometricAuthentication extends AuthState{

}
class AuthRetryBiometricAuthentication extends AuthState{

}
class IsFirstRegistration extends AuthState{

}