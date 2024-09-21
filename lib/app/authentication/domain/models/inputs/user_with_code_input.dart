
import 'package:equatable/equatable.dart';

class UserWithCodeInput extends Equatable {
  final String phone;
  final String code;

  const UserWithCodeInput(this.phone, this.code);

  @override
  List<Object?> get props => [phone, code];
}