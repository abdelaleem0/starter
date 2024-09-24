import 'package:starter/app/authentication/ui/builder_screen.dart';
import 'package:starter/app/authentication/ui/rotate_screen.dart';
import 'package:starter/app/authentication/utils/localization/authentication_localization.dart';
import 'package:starter/common/base/localization/app_languages.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import 'package:starter/common/ui/app_responsive/app_responsive_scaled_box.dart';
import 'package:starter/common/ui/app_responsive/mediaquery_scale_overrider.dart';
import 'package:starter/common/ui/custom_widgets/app_blocker_loader.dart';
import 'package:starter/common/utils/app_routes/nested_navigation.dart';
import 'package:starter/common/utils/app_routes/router_functions.dart';
import 'package:starter/common/utils/localization/common_localization.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:starter/common/blocs/app_language/app_language_bloc.dart';
import 'package:starter/common/blocs/app_language/app_language_event.dart';
import 'package:starter/common/blocs/app_language/app_language_state.dart';
import 'package:starter/common/blocs/authentication/authentication_bloc.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/di/app_injector.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class TheAppUser extends StatefulWidget {

  const TheAppUser({super.key});

  @override
  State<TheAppUser> createState() => _TheAppUserState();
}

class _TheAppUserState extends State<TheAppUser> {
  @override
  void initState() {
    PaintingBinding.instance.imageCache.maximumSizeBytes =
        500 * 1024 *1024; //200 MB
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return RotateScreenContainer(
      child: DevicePreview(
        enabled: false,
        builder: (BuildContext context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) {
                  return AppLanguageBloc(injector())
                    ..add(AppLanguageAppStarted());
                },
              ),
              BlocProvider(
                create: (context) {
                  return AuthenticationBloc();
                  // ..add(AppStartBiometricEvent());
                },
              ),
              BlocProvider(create: (context) => UserCubit()),
              // BlocProvider(
                // create: (context) => PurchaseCubit(),
              // ),
            ],
            child: BlocBuilder<AppLanguageBloc, AppLanguageState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: DevicePreview.appBuilder(
                    context,
                    MaterialApp(
                      key: ValueKey(state.locale.languageCode),
                      debugShowCheckedModeBanner: false,
                      color: AppColors.neutral_0,
                      navigatorKey: navigatorKey,
                      navigatorObservers: [
                        NestedNavObserver.instance,
                      ],
                      theme: ThemeData(
                        fontFamily: 'NotoSans',
                        primaryColor: AppColors.neutralColors1,
                        bottomSheetTheme: const BottomSheetThemeData(
                          backgroundColor: AppColors.neutralColors1,
                          surfaceTintColor: AppColors.neutralColors1,
                        ),
                        useMaterial3: false,
                        dialogTheme: const DialogTheme(
                          backgroundColor: AppColors.neutralColors1,
                          surfaceTintColor: AppColors.neutralColors1,

                        ),
                        scaffoldBackgroundColor: AppColors.neutralColors1,
                        canvasColor: AppColors.neutralColors1,
                        appBarTheme: const AppBarTheme(
                          systemOverlayStyle: SystemUiOverlayStyle.dark,
                          backgroundColor:  Colors.white,
                          surfaceTintColor: Colors.transparent,
                        ),
                      ),
                      locale: state.locale,
                      localizationsDelegates: const [
                        AuthenticationLocalization.delegate,
                        CommonLocalization.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        DefaultCupertinoLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: AppLanguages.supportedLocales,
                      title: "Starter",
                      builder: (context, child) {
                        return ScrollConfiguration(
                          behavior: RemoveScrollGlow(),

                          child: ResponsiveBreakpoints.builder(
                            breakpoints: [
                              const Breakpoint(start: 0, end: 450, name: MOBILE),
                              const Breakpoint(start: 451, end: 800, name: TABLET),
                              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                              const Breakpoint(
                                  start: 1921,
                                  end: double.infinity,
                                  name: '4K'),
                            ],
                            child: MediaQueryScaleOverrider(
                                child: PurchaseController(
                                    child: child!
                                )
                            ),
                          ),
                        );
                      },
                      initialRoute: '/',

                      onGenerateRoute: (settings) {

                        RouteInfoModel? routeInfo =
                        settings.arguments as RouteInfoModel?;

                        PageRoute pageRoute;
                        Widget page;
                        String? routeName = settings.name;

                        //set main page
                        if (routeName == '/') {
                          page = const BuilderScreen();
                        } else {
                          assert(routeInfo?.page != null); //route info can not be null here
                          page = routeInfo!.page;
                        }
                        //set responsive scaled box on the page
                        page = AppResponsiveScaledBox(
                          calculateMediaQuery: false,
                          child: page,
                        );

                        //set page route if passed
                        if (routeInfo?.materialPageRoute != null) {
                          pageRoute = routeInfo!.materialPageRoute!(page);
                        } else {
                          pageRoute = MaterialPageRoute(
                            settings: RouteSettings(name: routeName),
                            builder: (context) {
                              return page;
                            },
                          );
                        }

                        return pageRoute;
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// very important when you decide to another page and you already playing video or sound
// then you need to dispose based on push

class RemoveScrollGlow extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
