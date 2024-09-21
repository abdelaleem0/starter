import 'package:starter/app/authentication/domain/models/inputs/login_input.dart';
import 'package:starter/app/authentication/domain/use_case/user_login_use_case.dart';
import 'package:starter/app/authentication/ui/login/manager/user_login_state.dart';
import 'package:starter/common/base/async.dart';
import 'package:starter/common/utils/bloc_utils.dart';
import 'package:starter/di/app_injector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserLoginCubit extends Cubit<UserLoginState> {
  late final UserLoginUseCase _userLoginUseCase;

  UserLoginCubit() : super(const UserLoginState.initial()) {
    _userLoginUseCase = injector();
  }

  static UserLoginCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> userLoginFuc({
    required LoginInput input,
  }) async {
    emit(state.reduce(loginState: const Async.loading()));
    await collect(
      task: () async {
        final isComplete = await _userLoginUseCase.execute(input);
        emit(state.reduce(loginState: Async.success(isComplete)));
        emit(state.reduce(loginState: const Async.initial()));
      },
      onError: (errorMessage) {
        emit(
          state.reduce(
            errorMessage: errorMessage,
            loginState: Async.failure(
              errorMessage.toString(),
            ),
          ),
        );
      },
    );
  }

  @override
  void emit(UserLoginState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
