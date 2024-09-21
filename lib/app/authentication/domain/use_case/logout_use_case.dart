import 'package:starter/common/domain/exceptions/exceptions.dart';
import 'package:starter/common/domain/exceptions/status_codes.dart';
import 'package:starter/common/domain/repositories/common_repository.dart';
import 'package:starter/common/domain/use_cases/delete_token_use_case.dart';
import 'package:starter/common/utils/common.dart';
import 'package:eraser/eraser.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LogoutUseCase {
  final CommonRepository _repository;
  final DeleteCachedUserUseCase _deleteTokenUseCase;
  LogoutUseCase(this._repository,this._deleteTokenUseCase);

  final googleSignIn = GoogleSignIn(scopes: [
    "email",
    "profile",
  ]);

  Future<void> execute() async {
    await _googleLogout();
    await _logout();
    await clearAllNotification();
  }

  Future<void> _logout() async {
    try {
      await _repository.logout();
      await _deleteCachedUser();
    } on ApiRequestException catch(e) {
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

  Future<void> _googleLogout() async {
    try {
      await googleSignIn.signOut();
    } catch (e) {
      logDebug(e);
    }
  }


  Future<void> clearAllNotification() async {
    Eraser.clearAllAppNotifications();
  }
}
