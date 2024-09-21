import 'package:starter/common/domain/exceptions/exceptions.dart';
import 'package:starter/common/domain/exceptions/status_codes.dart';
import 'package:starter/common/domain/repositories/common_repository.dart';
import 'package:starter/common/domain/use_cases/delete_token_use_case.dart';

class DeleteAccountUseCase {
  final DeleteCachedUserUseCase _deleteTokenUseCase;
  final CommonRepository _commonRepository;

  DeleteAccountUseCase(this._commonRepository, this._deleteTokenUseCase);

  Future<void> call() async {
    try {
      await _commonRepository.deleteAccount();
      await _deleteCachedUser();
    } on ApiRequestException catch (e) {
      if (e.statusCode == StatusCodes.unauthorizedCode) {
        return;
      } else {
        rethrow;
      }
    }
  }

  Future<void> _deleteCachedUser() async {
    await _deleteTokenUseCase.execute();
  }
}
