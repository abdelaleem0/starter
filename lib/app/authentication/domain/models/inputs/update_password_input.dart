import 'package:equatable/equatable.dart';

class UpdatePasswordInput extends Equatable {
  final String email;
  final String newPassword;
  final String code;

  const UpdatePasswordInput({
    required this.email,
    required this.newPassword,
    required this.code,
  });

  Map<String, dynamic> toJson() => {
    "email": email,
    "newPassword": newPassword,
    "code": code,
  };

  @override
  List<Object?> get props => [email, newPassword, code];
}

