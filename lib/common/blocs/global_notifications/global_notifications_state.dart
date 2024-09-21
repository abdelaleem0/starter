import 'package:equatable/equatable.dart';

class GlobalNotificationsState extends Equatable {
  final int unseenNotificationsCount;
  final int unreadChatsCount;

  const GlobalNotificationsState(
      this.unseenNotificationsCount, this.unreadChatsCount);

  const GlobalNotificationsState.initial() : this(0, 0);

  GlobalNotificationsState reduce({
    int? unseenNotificationsCount,
    int? unreadChatsCount,
  }) {
    return GlobalNotificationsState(
        unseenNotificationsCount ?? this.unseenNotificationsCount,
        unreadChatsCount ?? this.unreadChatsCount,
    );
  }

  @override
  List<Object> get props => [
    unseenNotificationsCount,
    unreadChatsCount
  ];
}
