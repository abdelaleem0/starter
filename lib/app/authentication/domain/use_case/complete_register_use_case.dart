import 'package:starter/app/authentication/domain/models/inputs/complete_register_input.dart';
import 'package:starter/app/authentication/domain/repositories/user_authentication_repository.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import 'package:starter/common/domain/models/token.dart';
import 'package:starter/common/domain/use_cases/cached_user_data/set_cached_user_data_use_case.dart';
import 'package:starter/data/preferences/models/cached_user_data.dart';

class CompleteRegisterUseCase {
  final UserAuthenticationRepository _repository;
  final SetCachedUserDataUseCase _setCachedUserDataUseCase;

  CompleteRegisterUseCase(
    this._repository, this._setCachedUserDataUseCase,
  );

  Future<AppUserModel> execute(CompleteRegisterInput completeRegisterInput) async {
    final result = await _repository.completeRegister(completeRegisterInput);
    await _setCachedUserDataUseCase(CachedUserData(
        id: result.id ?? "", token: result.token ?? const Token("", false)));
    return result;
  }
}
