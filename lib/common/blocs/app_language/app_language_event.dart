import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AppLanguageEvent extends Equatable {
  const AppLanguageEvent();

  @override
  List<Object> get props => [];
}

class AppLanguageAppStarted extends AppLanguageEvent {}

class ChangeAppLanguage extends AppLanguageEvent {
  final Locale selectedLocale;

  const ChangeAppLanguage(this.selectedLocale);

  @override
  List<Object> get props => [selectedLocale];
}