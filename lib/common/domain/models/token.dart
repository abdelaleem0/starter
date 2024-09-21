import 'package:equatable/equatable.dart';

class Token extends Equatable {
  final String token;
  final bool isCompleteRegister;

  const Token(this.token, this.isCompleteRegister);

  @override
  List<Object?> get props => [
        token,
        isCompleteRegister,
      ];
}
