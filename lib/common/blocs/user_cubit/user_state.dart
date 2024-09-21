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
  final Transaction? transaction;
  final String? profilePicture;
  final bool? hasPassword;
  final AllowedFeatures? allowedUserFeatures;
  final bool hasNotOpenedNotification;

  const AppUserModel(
      {required this.token,
      this.firstName,
      this.username,
      required this.email,
      required this.id,
      required this.isComplete,
      required this.isFirstRegistration,
      this.transaction,
      this.profilePicture,
      this.hasPassword,
      this.allowedUserFeatures,
        required this.hasNotOpenedNotification,
      });

   AppUserModel.initial()
      : this(
            id: null,
            token: null,
            firstName: "",
            username: "",
            email: "",
            isComplete: false,
            isFirstRegistration: false,
            transaction: const Transaction.initial(),
            profilePicture: "",
            hasPassword: false,
            allowedUserFeatures: const AllowedFeatures.initial(),
     hasNotOpenedNotification: false,
        );

  AppUserModel copyWith(
      {String? firstName,
      String? username,
      String? id,
      Token? token,
      String? email,
      bool? isComplete,
      bool? isFirstRegistration,
      Transaction? transaction,
      String? profilePicture,
      bool? hasPassword,
        AllowedFeatures? allowedUserFeatures,
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
        transaction: transaction ?? this.transaction,
        profilePicture: profilePicture ?? this.profilePicture,
        hasPassword: hasPassword ?? this.hasPassword,
        allowedUserFeatures: allowedUserFeatures ??this.allowedUserFeatures,
      hasNotOpenedNotification: hasNotOpenedNotification ??this.hasNotOpenedNotification,
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
        transaction,
        profilePicture,
        hasPassword,
        allowedUserFeatures,

    hasNotOpenedNotification,
      ];

  @override
  String toString() {
    return 'AppUserModel{firstName: $firstName, username: $username, id: $id, token: $token, email: $email, isComplete: $isComplete, isFirstRegistration: $isFirstRegistration, transaction: $transaction, profilePicture: $profilePicture, hasPassword: $hasPassword, allowedUserFeatures: $allowedUserFeatures ,  hasNotOpenedNotification: $hasNotOpenedNotification}';
  }
}

class Transaction extends Equatable {
  final String id;

  const Transaction({required this.id});

  const Transaction.initial() : this(id: "");

  @override
  List<Object?> get props => [id];
}

class AllowedFeatures extends Equatable{
  final bool? createWeeklyPlan; // done
  final bool? accessMilestone; // done
  final bool? createGoal; // done
  final bool? createRelationshipWithAllah; // done
  final bool? createRelationshipWithOthers; // done
  final bool? createRelationshipWithMyself; // done
  final bool? accessFeelWell; // done
  final bool? accessEvents;
  final bool? attendEvent;
  final bool? accessInspire;
  final bool? createInspirePost;
  final bool? participateChallenges;
  final bool? canAccessFreeTrail;


  const AllowedFeatures({
    this.createWeeklyPlan,
    this.accessMilestone,
    this.createGoal,
    this.createRelationshipWithAllah,
    this.createRelationshipWithOthers,
    this.createRelationshipWithMyself,
    this.accessFeelWell,
    this.accessEvents,
    this.attendEvent,
    this.accessInspire,
    this.createInspirePost,
    this.participateChallenges,
    this.canAccessFreeTrail
  });


  const AllowedFeatures.initial():this(
    createWeeklyPlan: false,
    accessMilestone: false,
    createGoal: false,
    createRelationshipWithAllah: false,
    createRelationshipWithOthers: false,
    createRelationshipWithMyself: false,
    accessFeelWell: false,
    accessEvents: false,
    attendEvent: false,
    accessInspire: false,
    createInspirePost: false,
    participateChallenges: false,
    canAccessFreeTrail: false
  );


  AllowedFeatures modify({
    bool? createWeeklyPlan,
    bool? accessMilestone,
    bool? createGoal,
    bool? createRelationshipWithAllah,
    bool? createRelationshipWithOthers,
    bool? createRelationshipWithMyself,
    bool? accessFeelWell,
    bool? accessEvents,
    bool? attendEvent,
    bool? accessInspire,
    bool? createInspirePost,
    bool? participateChallenges,
    bool? canAccessFreeTrail
  }) {
    return AllowedFeatures(
      createWeeklyPlan: createWeeklyPlan ?? this.createWeeklyPlan,
      accessMilestone: accessMilestone ?? this.accessMilestone,
      createGoal: createGoal ?? this.createGoal,
      createRelationshipWithAllah: createRelationshipWithAllah ?? this.createRelationshipWithAllah,
      createRelationshipWithOthers: createRelationshipWithOthers ?? this.createRelationshipWithOthers,
      createRelationshipWithMyself: createRelationshipWithMyself ?? this.createRelationshipWithMyself,
      accessFeelWell: accessFeelWell ?? this.accessFeelWell,
      accessEvents: accessEvents ?? this.accessEvents,
      attendEvent: attendEvent ?? this.attendEvent,
      accessInspire: accessInspire ?? this.accessInspire,
      createInspirePost: createInspirePost ?? this.createInspirePost,
      participateChallenges: participateChallenges ?? this.participateChallenges,
      canAccessFreeTrail: canAccessFreeTrail ?? this.canAccessFreeTrail
    );
  }


  @override
  List<Object?> get props => [
        createWeeklyPlan,
        accessMilestone,
        createGoal,
        createRelationshipWithAllah,
        createRelationshipWithOthers,
        createRelationshipWithMyself,
        accessFeelWell,
        accessEvents,
        attendEvent,
        accessInspire,
        createInspirePost,
        participateChallenges,
        canAccessFreeTrail
      ];

}
