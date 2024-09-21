import 'package:starter/common/domain/models/token.dart';
import 'package:equatable/equatable.dart';

class LoginUserData extends Equatable {
  final String id;
  final String? profilePicture;
  final Token token;
  final String phone;

  const LoginUserData(
    this.id,
    this.profilePicture,
    this.token,
    this.phone,
  );


  @override
  List<Object?> get props => [
        id,
        profilePicture,
        token,
        phone,
      ];
}
