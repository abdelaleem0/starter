
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/common.dart';
import 'global_notifications_event.dart';
import 'global_notifications_state.dart';

class GlobalNotificationsBloc
    extends Bloc<GlobalNotificationsEvent, GlobalNotificationsState> {

  // late final UnseenNotificationsCountUseCase _unseenNotificationsCountUseCase;
  // late final UnreadChatsCountUseCase _unreadChatsCountUseCase;

  GlobalNotificationsBloc() : super(const GlobalNotificationsState.initial()) {
    _loadUseCases();
    on<FetchUnseenNotificationsCount>(_onFetchUnseenNotificationsCount);
    on<FetchUnreadChatsCount>(_onFetchUnreadChatsCount);
    on<GlobalNotificationsReset>(_onReset);
  }

  void _loadUseCases() {
    // _unseenNotificationsCountUseCase = injector();
    // _unreadChatsCountUseCase = injector();
  }

  void _onFetchUnseenNotificationsCount(
      FetchUnseenNotificationsCount event,
      Emitter<GlobalNotificationsState> emit
  ) async {
    try {
      // final data = await _unseenNotificationsCountUseCase.execute();
      // emit(state.reduce(
      //     unseenNotificationsCount: data
      // ));
    } catch(e) {
      logDebug(e);
    }
  }

  void _onFetchUnreadChatsCount(
      FetchUnreadChatsCount event,
      Emitter<GlobalNotificationsState> emit
  ) async {
    try {
      // final data = await _unreadChatsCountUseCase.execute();
      // emit(state.reduce(
      //     unreadChatsCount: data
      // ));
    } catch(e) {
      logDebug(e);
    }
  }

  void _onReset(
    GlobalNotificationsReset event,
    Emitter<GlobalNotificationsState> emit,
  ) {
    emit(const GlobalNotificationsState.initial());
  }
}