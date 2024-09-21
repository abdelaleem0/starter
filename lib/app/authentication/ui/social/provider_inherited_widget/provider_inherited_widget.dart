import 'package:starter/app/authentication/domain/models/social/social_provider_type.dart';
import 'package:flutter/material.dart';

class ProviderInheritedWidget extends InheritedWidget {
  final SocialProviderTypeEnum provider;

  const ProviderInheritedWidget(
      {super.key, required super.child, required this.provider});

  static of(BuildContext context) {
    ProviderInheritedWidget? inherited = context
        .dependOnInheritedWidgetOfExactType<ProviderInheritedWidget>();
    assert(inherited != null, 'Inherited not found in widget tree');
    return inherited;
  }

  @override
  bool updateShouldNotify(covariant ProviderInheritedWidget oldWidget) {
    return oldWidget.provider != provider;
  }
}