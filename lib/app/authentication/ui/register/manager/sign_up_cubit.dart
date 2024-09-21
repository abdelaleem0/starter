import 'package:starter/app/authentication/domain/models/inputs/register_input.dart';
import 'package:starter/app/authentication/domain/use_case/user_register_use_case.dart';
import 'package:starter/app/authentication/ui/register/manager/sign_up_state.dart';
import 'package:starter/common/base/async.dart';
import 'package:starter/common/utils/bloc_utils.dart';
import 'package:starter/di/app_injector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  late final UserRegisterUseCase _userRegisterUseCase;

  SignUpCubit() : super(const SignUpState.initial()) {
    _userRegisterUseCase = injector();
  }

  static SignUpCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> userRegisterFuc({
    required RegisterInput input,
  }) async {
    emit(state.reduce(userRegisterState: const Async.loading()));
    await collect(
      task: () async {
        await _userRegisterUseCase.execute(input);
        emit(state.reduce(userRegisterState: const Async.successWithoutData()));
        emit(state.reduce(userRegisterState: const Async.initial()));
      },
      onError: (errorMessage) {
        emit(
          state.reduce(
            errorMessage: errorMessage,
            userRegisterState: Async.failure(
              errorMessage.toString(),
            ),
          ),
        );
      },
    );
  }

  @override
  void emit(SignUpState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
