import 'package:starter/app/authentication/domain/repositories/user_authentication_repository.dart';

class ForgetPasswordUseCase {
  final UserAuthenticationRepository _repository;

  ForgetPasswordUseCase(
    this._repository,
  );

  Future<bool> execute(String email) async {
    final result = await _repository.forgetPassword(email);
    return result;
  }

}
