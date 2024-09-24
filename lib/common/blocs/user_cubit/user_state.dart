part of 'user_cubit.dart';

class UserState extends Equatable {
  final Async<AppUserModel> userData;
  final Async<void> reAuthenticateState;

  const UserState(this.userData, this.reAuthenticateState);

  const UserState.initial()
      : this(const Async.initial(), const Async.initial());

  UserState reduce(Async<AppUserModel>? userData,
      {Async<void>? reAuthenticateState}) {
    return UserState(userData ?? this.userData,
        reAuthenticateState ?? this.reAuthenticateState);
  }

  @override
  List<Object?> get props => [userData, reAuthenticateState];
}

class AppUserModel extends Equatable {
  final String? firstName;
  final String? username;
  final String? id;
  final Token? token;
  final String email;
  final bool isComplete;
  final bool isFirstRegistration;
  final String? profilePicture;
  final bool? hasPassword;
  final bool hasNotOpenedNotification;

  const AppUserModel({
    required this.token,
    this.firstName,
    this.username,
    required this.email,
    required this.id,
    required this.isComplete,
    required this.isFirstRegistration,
    this.profilePicture,
    this.hasPassword,
    required this.hasNotOpenedNotification,
  });

  const AppUserModel.initial()
      : this(
          id: null,
          token: null,
          firstName: "",
          username: "",
          email: "",
          isComplete: false,
          isFirstRegistration: false,
          profilePicture: "",
          hasPassword: false,
          hasNotOpenedNotification: false,
        );

  AppUserModel copyWith({
    String? firstName,
    String? username,
    String? id,
    Token? token,
    String? email,
    bool? isComplete,
    bool? isFirstRegistration,
    String? profilePicture,
    bool? hasPassword,
    bool? hasNotOpenedNotification,
  }) {
    return AppUserModel(
      firstName: firstName ?? this.firstName,
      username: username ?? this.username,
      id: id ?? this.id,
      token: token ?? this.token,
      email: email ?? this.email,
      isComplete: isComplete ?? this.isComplete,
      isFirstRegistration: isFirstRegistration ?? this.isFirstRegistration,
      profilePicture: profilePicture ?? this.profilePicture,
      hasPassword: hasPassword ?? this.hasPassword,
      hasNotOpenedNotification:
          hasNotOpenedNotification ?? this.hasNotOpenedNotification,
    );
  }

  @override
  List<Object?> get props => [
        firstName,
        username,
        id,
        token,
        email,
        isComplete,
        isFirstRegistration,
        profilePicture,
        hasPassword,
        hasNotOpenedNotification,
      ];

  @override
  String toString() {
    return 'AppUserModel{firstName: $firstName, username: $username, id: $id, token: $token, email: $email, isComplete: $isComplete, isFirstRegistration: $isFirstRegistration, profilePicture: $profilePicture, hasPassword: $hasPassword,hasNotOpenedNotification: $hasNotOpenedNotification}';
  }
}
