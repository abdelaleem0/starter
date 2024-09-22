import 'dart:async';
import 'package:starter/common/blocs/app_language/app_language_bloc.dart';
import 'package:starter/common/blocs/authentication/authentication_bloc.dart';
import 'package:starter/common/blocs/authentication/events.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import 'package:starter/common/ui/custom_widgets/app_buttons/app_material_buttons.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/localization/common_localizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  static const Duration delayDuration = Duration(milliseconds: 3000);
  Timer? timer;
  bool timerFinished = false;
  String lang ='ar';

  @override
  void initState() {

    //to increase image cache size
    PaintingBinding.instance.imageCache.maximumSizeBytes = 300 << 20;

    lang = BlocProvider.of<AppLanguageBloc>(context).state.locale.languageCode;
    timer = Timer(delayDuration, () async {
      final token = await context.read<UserCubit>().getToken();
      if (token == true) {
        if(mounted){
          await BlocProvider.of<UserCubit>(context).initializeUserData();
        }
      } else {
        if(mounted){
          AuthenticationBloc.of(context).add(AppStartedEvent());
        }
      }

      timerFinished = true;
      timer?.cancel();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }


  //todo add your images here for caching
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return
       AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocConsumer<UserCubit, UserState>(
                  listener: (context, state) {
                    if (state.userData.isSuccess) {
                      if (state.userData.data?.id == null ||
                          state.userData.data?.id?.isEmpty == true) {
                        AuthenticationBloc.of(context).add(AppStartedEvent());
                        // BlocProvider.of<UserCubit>(context).initializeUserData();
                      } else {
                        if(state.userData.data?.isComplete == true){
                          if(state.userData.data?.isFirstRegistration == false){
                            AuthenticationBloc.of(context).add(AppStartBiometricEvent());
                            // AuthenticationBloc.of(context).add(AuthenticatedEvent());
                          }
                          else{
                            AuthenticationBloc.of(context).add(IsFirstRegistrationEvent());
                          }
                        }
                        else{
                          // if he doesn't need that just emit AppStartedEvent
                          AuthenticationBloc.of(context).add(const AuthFirstNameEvent(checkLogout: true));
                        }

                      }
                    }
                    if (state.userData.isFailure) {

                    }
                    if(state.reAuthenticateState.isSuccess){
                      BlocProvider.of<AuthenticationBloc>(context).add(LoggedOutEvent());
                    }
                  },
                  builder: (context, state) {
                      return timerFinished
                          ? state.userData.isFailure
                              ? UnconstrainedBox(
                                child: AppMaterialButtons.primaryButton(
                                    text: CommonLocalizer.retry,
                                    isExpanded: false,
                                    textColor: AppColors.primary_400,
                                    buttonColor: AppColors.neutral_0,
                                    fontSize: Dimensions.xLarge,
                                    margin: const EdgeInsets.symmetric(horizontal: Dimensions.xxxxLarge),
                                    height: 50,
                                    onPressed: () {
                                      BlocProvider.of<UserCubit>(context)
                                          .initializeUserData();
                                    },
                                  ),

                    )
                              : const SizedBox()
                          : const SizedBox();
                  },
                ),
                const SizedBox(height: PaddingDimensions.x4Large,)
              ],
            ),
          ),
        ),

    );
  }
}
