import 'package:starter/app/authentication/domain/repositories/user_authentication_repository.dart';

class IsUserNameExistsUseCase {
  final UserAuthenticationRepository _userAuthenticationRepository;

  IsUserNameExistsUseCase(this._userAuthenticationRepository);

  Future<bool> execute(String userName) async {
    return _userAuthenticationRepository.isUserNameExists(userName);
  }
}