import 'package:starter/app/authentication/ui/rotate_screen.dart';
import 'package:starter/common/blocs/authentication/authentication_bloc.dart';
import 'package:starter/common/blocs/authentication/states.dart';
import 'package:starter/common/ui/splash_page/splash_page.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BuilderScreen extends StatefulWidget {
  const BuilderScreen({super.key});
  static const String routeName = "/";

  @override
  State<BuilderScreen> createState() => _BuilderScreenState();
}

class _BuilderScreenState extends State<BuilderScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is! AuthLoading && current is! AuthFailure,
      buildWhen: (previous, current) =>
          current is! AuthLoading && current is! AuthFailure,
      listener: (context, state) {
        if(state is AuthAuthenticated){
          // PurchaseCubit.of(context).loadPastPurchases(); // todo very important .in IOS it will ask the user to enter its credential .
        }
      },
      builder: (context, state) {
        final rotateState = RotateScreenContainer.of(context).rotate;

          if(rotateState){
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight
            ]);
          }else{
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
          }

        final Widget root;
        if (state is AuthUninitialized) {
          root =const Splash();
            // root = const SetGoalFeedBackPage();
            // root = const MoveItCheckInPage();
          //root = const InspirePage();
        }

         else {
          root = const HomePage();
        }
        return state is AuthAuthenticated
            ? ColoredBox(
                color: AppColors.neutralBackground,
                key: ValueKey(state),
                child: root,
              )
            : AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: ColoredBox(
                  color: AppColors.neutralBackground,
                  key: ValueKey(state),
                  child: root,
                ),
              );
      },
    );
  }
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

