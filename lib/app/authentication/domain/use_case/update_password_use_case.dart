import 'package:starter/app/authentication/domain/models/inputs/update_password_input.dart';
import 'package:starter/app/authentication/domain/repositories/user_authentication_repository.dart';

class ResetPasswordUseCase {
  final UserAuthenticationRepository _repository;

  ResetPasswordUseCase(this._repository);

  Future<String> execute(UpdatePasswordInput updatePasswordInput) async {
    return await _repository.updatePassword(updatePasswordInput);
  }
}
