import 'package:flutter/material.dart';

class AppRouteNavigator {
  static Future<dynamic> push(
      BuildContext context,
      String routeName,
      Widget widget,
      ) async {
    return await Navigator.of(context, rootNavigator: true).pushNamed(
        routeName,
        arguments: RouteInfoModel(
          page: widget,
        )
    );
  }



  // static Future<T?> pushAnimatedOpacity<T>(
  //     BuildContext context,
  //     String routeName,
  //     Widget widget, {
  //       Duration? duration,
  //       bool fullscreenDialog = false,
  //       Color barrierBgColor = Colors.white,
  //     }) async {
  //   return await Navigator.of(context, rootNavigator: true).pushNamed(
  //       routeName,
  //       arguments: RouteInfoModel(
  //         page: widget,
  //         materialPageRoute: (page) {
  //           return FadeTransitionRoute<T>(
  //             isFullscreenDialog: fullscreenDialog,
  //             child: page,
  //             duration: duration,
  //             routeName: routeName,
  //             barrierBgColor: barrierBgColor,
  //           );
  //         },
  //       )
  //   );
  // }

  static Future<void> pushReplacement(BuildContext context,
      String routeName,
      Widget widget,
      ) async {
    //it will execute the enter animation
    await Navigator.of(context, rootNavigator: true).pushReplacementNamed(
        routeName,
        arguments: RouteInfoModel(
          page: widget,
        ),
    );
  }

  static Future<void> pushAndRemoveUntil(
      BuildContext context, String routeName, Widget widget,
      {String? removeUntil,bool useResponsiveScaledBox = true}) async {
    await Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
      routeName,
      arguments: RouteInfoModel(
        page: widget,
      ),
          (route) {
        if (removeUntil == null) {
          return false;
        }
        return route.settings.name == removeUntil;
      },
    );
  }

  static void pop<T>(
      BuildContext context, {
        bool rootNavigator = true,
        T? data,
      }) {
    final nav = Navigator.of(context, rootNavigator: rootNavigator);
    if (nav.canPop()) {
      nav.pop(data);
    }
  }

  static void popUntil(BuildContext context,
      {String? removeUntil, bool rootNavigator = true}) {
    Navigator.of(context, rootNavigator: rootNavigator).popUntil(
          (route) {
        if (removeUntil == null) {
          return route.isFirst;
        }
        return route.settings.name == removeUntil;
      },
    );
  }
/*
static void restorablePushReplacement(BuildContext context,String routeName,{Object? arguments,Object? results}){
    Navigator.restorablePushReplacement(
        context,routeName,
        arguments: arguments,
        result: results,
    );
  }*/
}

class RouteInfoModel {
  final Widget page;
  final PageRoute Function(Widget child)? materialPageRoute;

  const RouteInfoModel({
    required this.page,
    this.materialPageRoute,
  });
}