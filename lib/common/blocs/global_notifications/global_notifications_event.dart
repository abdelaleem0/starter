import 'package:equatable/equatable.dart';

abstract class GlobalNotificationsEvent extends Equatable {
  const GlobalNotificationsEvent();

  @override
  List<Object> get props => [];
}

class FetchUnseenNotificationsCount extends GlobalNotificationsEvent {}

class FetchUnreadChatsCount extends GlobalNotificationsEvent {}

class GlobalNotificationsReset extends GlobalNotificationsEvent {}
