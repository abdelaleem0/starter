import 'package:get_it/get_it.dart';
import 'localizations_container.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.registerSingleton(LocalizationsContainer());

  injector.pushNewScope();
  await registerAppDependencies();
}

//TODO:use this func with AuthLogout func to resetScope.
Future<void> resetScopeDependencies() async {
  await injector.resetScope();
  await registerAppDependencies();
}

Future<void> registerAppDependencies() async {
  // DataDi.initialize();
  // CommonDi.initialize();
  // AuthenticationDi.initialize();
  // WeeklyPlannerDi.initialize();
  // SetGoalDi.initialize();
  // PurchaseDi.initialize();
  // WeeklyPlannerFeedbackDi.initialize();
  // InitialHomeDi.initialize();
  // HomeDi.initialize();
  // WeeklyPlannerSketchDi.initialize();
  // WeeklyPlanerDi.initialize();
  // ConnectDi.initialize();
  // ChallengesDi.initialize();
  // EventsDi.initialize();
  // InspireDi.initialize();
  // LeaderBoardDi.initialize();
  // MenuDi.initialize();
  // FeelWellDi.initialize();
  // NotificationsDi.initialize();
  // MediaUtilsDi.initialize();
  // RelationshipDi.initialize();
}
