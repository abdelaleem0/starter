import 'package:starter/app/authentication/domain/use_case/complete_register_use_case.dart';
import 'package:starter/app/authentication/domain/use_case/is_username_exists_use_case.dart';
import 'package:starter/app/authentication/ui/complete_register/user_name/user_name_state.dart';
import 'package:starter/common/base/async.dart';
import 'package:starter/common/utils/bloc_utils.dart';
import 'package:starter/di/app_injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserNameCubit extends Cubit<UserNameState> {
  late final CompleteRegisterUseCase _completeRegisterUseCase;
  late final IsUserNameExistsUseCase _isUserNameExistsUseCase;

  void _loadInjector() {
    _completeRegisterUseCase = injector();
    _isUserNameExistsUseCase = injector();
  }

  UserNameCubit() : super(const UserNameState.initial()) {
    _loadInjector();
  }


  Future<void> checkUsernameExists({
    required String userName,
  }) async {
    emit(state.reduce(isUserNameExists: const Async.loading()));
    await collect(
      task: () async {
        await _isUserNameExistsUseCase.execute(userName);
        emit(state.reduce(isUserNameExists: const Async.successWithoutData()));
      },
      onError: (errorMessage) {
        emit(state.reduce(
          isUserNameExists: Async.failure(errorMessage),
        ));
      },
    );
  }

  void setUserNameStateToInitial() {
    emit(state.reduce(isUserNameExists: const Async.initial()));
  }

  @override
  void emit(UserNameState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
