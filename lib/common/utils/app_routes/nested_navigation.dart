import 'package:flutter/material.dart';


class NestedNavObserver extends NavigatorObserver{
  NestedNavObserver._();

  static final instance = NestedNavObserver._();

  ValueNotifier<List<String?>> navStack = ValueNotifier<List<String?>>([]);
  BuildContext? nestedContext;

  bool isCurrentPage(String routeName) {
    if (navStack.value.isNotEmpty) {
      return navStack.value.last == routeName;
    }
    return false;
  }

  void clearNavStack() {
    navStack.value = List.from([]);
  }

  void setContext(BuildContext context) {
    nestedContext = context;
  }

  bool isBeforeMainHostPage() {
    return navStack.value.isEmpty;
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (previousRoute != null && route.settings.name != null) {
      if(navStack.value.isNotEmpty){
        final List<String> newList = List.from(navStack.value);
        newList.removeLast();
        navStack.value = newList;
      }
    }
    if (navStack.value.last == "/") {
    } else {
      // SoundsManager.instance.dispose();
    }
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    final String? currentRouteName = route.settings.name;

    if(currentRouteName != null){
        final List<String> newList = List.from(navStack.value);
        newList.add(currentRouteName);
        navStack.value = newList;
    }

    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    if (previousRoute != null && route.settings.name != null) {
      if(navStack.value.isNotEmpty){
        final List<String> newList = List.from(navStack.value);
        newList.removeLast();
        navStack.value = newList;
      }
    }
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (oldRoute != null) {
      if(navStack.value.isNotEmpty){
        final List<String> newList = List.from(navStack.value);
        newList.removeLast();
        navStack.value = newList;
      }
    }
    if (newRoute != null && oldRoute?.settings.name != null) {
      final String? currentRouteName = newRoute.settings.name;

      if(currentRouteName != null){
        final List<String> newList = List.from(navStack.value);
        newList.add(currentRouteName);
        navStack.value = newList;
      }
    }
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }


}




