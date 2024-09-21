import 'package:equatable/equatable.dart';

class RegisterInput extends Equatable {
  final String email;
  final String password;
  final String? fcmToken;

  const RegisterInput(
      {required this.email, required this.password, this.fcmToken});

  RegisterInput modify({String? email, String? password, String? fcmToken}) {
    return RegisterInput(
        email: email ?? this.email,
        password: password ?? this.password,
        fcmToken: fcmToken ?? this.fcmToken);
  }

  @override
  List<Object?> get props => [email, password, fcmToken];
}
