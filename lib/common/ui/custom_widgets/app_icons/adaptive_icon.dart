import 'package:starter/common/blocs/app_language/app_language_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LangAdaptiveIcon extends StatelessWidget {
  final Widget child;
  const LangAdaptiveIcon({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: context.read<AppLanguageBloc>().state.locale.languageCode == "ar" ? 90: 0,
      child: child,
    );
  }
}
