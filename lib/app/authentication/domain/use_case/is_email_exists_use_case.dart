import 'package:starter/app/authentication/domain/repositories/user_authentication_repository.dart';

class IsEmailExistsUseCase{
  final UserAuthenticationRepository _userAuthenticationRepository;

  IsEmailExistsUseCase(this._userAuthenticationRepository);

  Future<bool> execute(String email) async {
    return await _userAuthenticationRepository.isEmailExists(email);
  }
}