import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:starter/app/authentication/domain/use_case/is_user_authenticated_use_case.dart';
import 'package:starter/app/authentication/domain/use_case/logout_use_case.dart';
import 'package:starter/common/domain/use_cases/biometric/delete_biometric_use_case.dart';
import 'package:starter/common/domain/use_cases/biometric/is_biometric_enabled_use_case.dart';
import 'package:starter/common/domain/use_cases/delete_account_use_case.dart';
import 'package:starter/common/domain/use_cases/delete_token_use_case.dart';
import 'package:starter/common/domain/use_cases/update_fcm_token_use_case.dart';
import 'package:starter/data/preferences/preferences_helper.dart';
import 'package:starter/data/preferences/shared_preferences_helper_imp.dart';
// import 'package:starter/notifications/utils/notifications_permissions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/common/utils/bloc_utils.dart';
import 'package:starter/common/utils/common.dart';

import 'package:starter/di/app_injector.dart';

import 'states.dart';

import 'events.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthState> {
  static AuthenticationBloc of(BuildContext context) {
    return BlocProvider.of(context);
  }

  late final UserAuthenticatedUseCase _isUserAuthenticatedUseCase;
  late final LogoutUseCase _logoutUseCase;
  late final DeleteAccountUseCase _deleteAccountUseCase;
  late final UpdateFcmTokenUseCase _updateFcmTokenUseCase;
  late final IsBiometricEnabledUseCase _isBiometricEnabledUseCase;
  late final DeleteBiometricUseCase _deleteBiometricUseCase;
  late final DeleteCachedUserUseCase _deleteCachedUserUseCase;

  StreamSubscription? _streamSubscription ;

  AuthenticationBloc() : super(AuthUninitialized()) {
    _loadUseCases();
    on<AppStartBiometricEvent>(_onBiometricChecked);
    on<AppRetryBiometricEvent>(_onRetryBiometricChecked);
    on<AppEnableBiometricEvent>(_onEnablingBiometricChecked);
    on<AppStartedEvent>(_onAppStarted);
    on<AuthenticatedEvent>(_onAuthenticated);
    on<AuthRestartEvent>(_onAuthRestart);
    on<LoggedOutEvent>(_onLogout);
    on<DeleteAccountEvent>(deleteAccount);
    on<AuthFirstNameEvent>(_onFirstName);
    on<AuthUserEmailEvent>(_onUserEmail);
    on<IsFirstRegistrationEvent>(_onFirstRegistration);
  }

  void _loadUseCases() {
    _isUserAuthenticatedUseCase = injector();
    _logoutUseCase = injector();
    _deleteAccountUseCase = injector();
    _isBiometricEnabledUseCase = injector();
    _deleteBiometricUseCase = injector();
    _updateFcmTokenUseCase = injector();
    _deleteCachedUserUseCase = injector();
  }

  Future<void> _onAppStarted(
    AppStartedEvent event,
    Emitter<AuthState> emit,
  ) async {
    // await initializeFirebase();
    //Todo(Delete this comment after checking)
    // FirebaseMessaging.instance.onTokenRefresh.listen((event) {
    //   _updateFcmTokenUseCase.execute(event);
    // });
    logDebug('AuthStarted');
    await startMainApp(emit);
  }

  void _onAuthenticated(
    AuthenticatedEvent event,
    Emitter<AuthState> emit,
  ) async {
    // unsubscribeToGuestTopic();
    await authenticated(emit);
  }

  void _onFirstRegistration(
    IsFirstRegistrationEvent event,
    Emitter<AuthState> emit,
  ) async {
    await isFirstRegistration(emit);
  }

  void _onAuthRestart(
    AuthRestartEvent event,
    Emitter<AuthState> emit,
  ) async {
    await collect(
      task: () async {
        logDebug('Auth Logged out');
        try {
          await _deleteCachedUserUseCase.execute();
          emit(AuthUnauthenticated());
        } catch (e) {
          emit(AuthFailure("Something went wrong"));
        }
      },
      onError: (errorMessage) async {
        logDebug('Auth Failure');
        emit(AuthFailure("Something went wrong"));
      },
    );
  }

  void _onLogout(
    LoggedOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    logDebug('AuthLogout');
    emit(AuthLoading());

    await collect(task: () async {
      await _logoutUseCase.execute();
      await _deleteBiometricUseCase.execute();
      await resetScopeDependencies();

      if(_streamSubscription != null) {
        _streamSubscription?.cancel();
      }
      emit(AuthUnauthenticated());


    }, onError: (errorMessage) {
      if (errorMessage == 'Server Error, try again later') {
        ///ToDo : no internet message
        errorMessage = 'No Connection , Try again ';
      }
      emit(AuthFailure(errorMessage));
    });
  }

  void deleteAccount(
      DeleteAccountEvent event, Emitter<AuthState> emit,) async {
    await collect(task: () async {
      emit(AuthLoading());
      await _deleteAccountUseCase.call();
      await resetScopeDependencies();
      emit(AuthUnauthenticated());

    }, onError: (message) {
      if (message == 'Server Error, try again later') {
        ///ToDo : no internet message
        message = 'No Connection , Try again ';
      }
      emit(AuthFailure(message));
    });

  }

  Future<void> authenticated(Emitter<AuthState> emit) async {
    logDebug('AuthAuthenticated');
    _streamSubscription = FirebaseMessaging.instance.onTokenRefresh.listen((event) {
      _updateFcmTokenUseCase.execute(event);
    });
    emit(AuthAuthenticated());
  }

  Future<void> startMainApp(Emitter<AuthState> emit) async {
    await checkIsFirstAppLaunch();
    final isAuthenticated = await isUserAuthenticated();
    //isLoggedIn
    if (isAuthenticated) {
      await authenticated(emit);
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> checkIsFirstAppLaunch()async
  {
    final SharedPreferencesHelperImp prefs = SharedPreferencesHelperImp();
    if (await prefs.getIsFirstAppLaunch() == true) {
      PreferencesHelper storage = injector();
      await storage.deleteToken();

      await prefs.setIsFirstAppLaunch(false);
    }
  }

  Future<bool> isUserAuthenticated() async {
    final result = await _isUserAuthenticatedUseCase.execute();
    return result;
  }

  void _onFirstName(AuthFirstNameEvent event, Emitter<AuthState> emit) {
    emit(AuthFirstName(checkLogout: event.checkLogout));
  }

  void _onUserEmail(AuthUserEmailEvent event, Emitter<AuthState> emit) {
    emit(AuthUserEmail());
  }

  Future<void> _onBiometricChecked(
      AppStartBiometricEvent event, Emitter<AuthState> emit) async {
    // todo take this to splash page
    if (await _isBiometricEnabledUseCase.execute() ) {
      emit(AuthStartBiometricAuthentication());
    } else {
      await _onAppStarted(AppStartedEvent(), emit);
    }
  }

  Future<void> _onRetryBiometricChecked(
      AppRetryBiometricEvent event, Emitter<AuthState> emit) async {
    emit(AuthRetryBiometricAuthentication());
  }

  Future<void> _onEnablingBiometricChecked(
      AppEnableBiometricEvent event, Emitter<AuthState> emit) async {
    emit(AuthEnabledBiometricAuthenticated());
  }

  Future<void> isFirstRegistration(Emitter<AuthState> emit) async {
    emit(IsFirstRegistration());
  }
}
