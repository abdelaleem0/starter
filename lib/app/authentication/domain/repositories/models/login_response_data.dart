import 'package:starter/common/domain/models/token.dart';
import 'package:equatable/equatable.dart';

class LoginResponseData extends Equatable {
  final String id;
  final String email;
 final Token token;

  const LoginResponseData(
    this.id,
    this.email,
    this.token,
  );


  @override
  List<Object?> get props => [
        id,
        email,
        token,
      ];
}
