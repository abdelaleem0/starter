import 'package:equatable/equatable.dart';

class LoginInput extends Equatable {
  final String email;
  final String password;
  final String? fcmToken;

  const LoginInput(
      {required this.password, required this.email, this.fcmToken});

  LoginInput modify({String? email, String? password, String? fcmToken}) {
    return LoginInput(
        email: email ?? this.email,
        password: password ?? this.password,
        fcmToken: fcmToken ?? this.fcmToken);
  }

  @override
  List<Object?> get props => [email, password, fcmToken];
}
