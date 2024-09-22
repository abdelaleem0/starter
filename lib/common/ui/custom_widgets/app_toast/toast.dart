import 'dart:async';

import 'package:starter/common/ui/custom_widgets/app_icons/app_icon.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

void errorToast(BuildContext context,
    {required String message, Duration? duration}) {
  AppToast().error(context, message: message, duration: duration);
}

void successToast(BuildContext context,
    {required String message, Duration? duration, Color? backgroundColor}) {
  AppToast().success(context,
      message: message, duration: duration, backgroundColor: backgroundColor);
}

void defaultToast(BuildContext context,
    {required String message, Duration? duration, Color? backgroundColor}) {
  AppToast().defaults(context,
      message: message, duration: duration, backgroundColor: backgroundColor);
}

/// [_toastLongDuration] long duration to hide or dispose toast after
const Duration _toastLongDuration = Duration(seconds: 4);

/// [_showToastDuration] animation time to show toast
const Duration _showToastDuration = Duration(milliseconds: 300);

/// [_reverseToastDuration] animation time to dispose or hide toast
const Duration _reverseToastDuration = Duration(milliseconds: 200);

/// [_toastRadius] toast radius shape
const double _toastRadius = Dimensions.largeRadius;

/// [AppToast] class contains all toast type error , success , hint
class AppToast {
  static AppToast? _instance;

  AppToast._();

  factory AppToast() {
    _instance ??= AppToast._();
    return _instance!;
  }

  /// declare [_overlayEntry]  [OverlayEntry] that shown over screen.
  OverlayEntry? _overlayEntry;

  void error(BuildContext context,
      {required String message, Duration? duration}) {
    _overlayEntry?.remove();
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => _Toast(
        title: message,
        onDismiss: () {
          dismissToast();
        },
        borderColor: AppColors.semanticColorsError4Default,
        textStyle: TextStyles.regular(
          fontSize: Dimensions.xLarge,
          color: AppColors.neutralColors7,
        ),
        leadingIcon: Iconsax.info_circle5,
        color: AppColors.semanticColorsError6,
        leadingIconColor: AppColors.semanticColorsError4Default,
        duration: duration,
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void success(BuildContext context,
      {required String message, Duration? duration, Color? backgroundColor}) {
    _overlayEntry?.remove();
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => _Toast(
        title: message,
        onDismiss: () {
          dismissToast();
        },
        borderColor: backgroundColor ?? AppColors.semanticColorsSuccess4Default,
        textStyle: TextStyles.regular(
            fontSize: Dimensions.xLarge, color: AppColors.neutralColors7),
        color: backgroundColor ?? AppColors.semanticColorsSuccess6,
        leadingIcon: Icons.check_circle,
        leadingIconColor: AppColors.semanticColorsSuccess4Default,
        duration: duration,
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void dismissToast() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

void defaults(BuildContext context,
    {required String message, Duration? duration, Color? backgroundColor}) {
  _overlayEntry?.remove();
  _overlayEntry = OverlayEntry(
    builder: (BuildContext context) => _Toast(
      title: message,
      onDismiss: () {
        dismissToast();
      },
      borderColor: backgroundColor ?? AppColors.blackColor,
      textStyle: TextStyles.regular(
          fontSize: Dimensions.xLarge, color: AppColors.neutral_0),
      color: backgroundColor ?? AppColors.blackColor,
      // leadingIcon: Icons.check_circle,
      leadingIconColor:AppColors.blackColor,
      duration: duration,
    ),
  );
  Overlay.of(context).insert(_overlayEntry!);
}
}
class _Toast extends StatefulWidget {
  const _Toast(
      {required this.onDismiss,
      this.color,
      this.borderColor,
      this.textStyle,
      required this.title,
      this.leadingIcon,
      this.leadingIconColor,
      this.duration, this.leadingIconPath});
  final VoidCallback onDismiss;
  final Color? color;
  final Color? borderColor;
  final TextStyle? textStyle;
  final String title;
  final IconData? leadingIcon;
  final String? leadingIconPath;
  final Color? leadingIconColor;
  final Duration? duration;

  @override
  State<_Toast> createState() => _ToastState();
}

class _ToastState extends State<_Toast> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late CurvedAnimation _animation;
  final Tween<Offset> _positionTween = Tween<Offset>(
    begin: const Offset(0.0, -1.0),
    end: Offset.zero,
  );

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: _showToastDuration,
      reverseDuration: _reverseToastDuration,
    );
    _animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
        reverseCurve: Curves.decelerate);

    _animationController.forward();
    _dismissToastAfterDuration();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          elevation: 0,
          color: Colors.transparent,
          child: SafeArea(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return SlideTransition(
                  position: _positionTween.animate(_animation),
                  child: child,
                );
              },
              child: GestureDetector(
                /// detect drag message to up to dismiss
                onVerticalDragEnd: (details) {
                  if ((details.primaryVelocity ?? 0) < 0) {
                    _onDismiss();
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: PaddingDimensions.xLarge,vertical: PaddingDimensions.medium),
                  padding: const EdgeInsets.all(Dimensions.large),
                  decoration: BoxDecoration(
                      color: widget.color ?? AppColors.forthColor,
                      borderRadius: BorderRadius.circular(_toastRadius),
                      border: Border.all(
                          width: 1,
                          color: widget.borderColor ?? Colors.transparent)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Visibility(
                          visible: widget.leadingIcon != null ||
                              widget.leadingIconPath != null,
                          replacement: const SizedBox(),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(
                                end: Dimensions.normal),
                            child: widget.leadingIconPath != null
                                ? AppIcons.getSvgIcon(
                                    imagePath: widget.leadingIconPath ?? "",
                                    color: widget.leadingIconColor,
                                  )
                                : Icon(
                                    widget.leadingIcon,
                                    color: widget.leadingIconColor,
                                  ),
                          )),
                      Flexible(
                        child: Text(
                          widget.title,
                          style: widget.textStyle,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _dismissToastAfterDuration() {
    Timer(
      widget.duration ?? _toastLongDuration,
      () {
        // use mounted here to prevent do dismiss animation if controller disposed
        if (mounted) {
          _onDismiss();
        }
      },
    );
  }

  void _onDismiss() {
    _animationController.reverse().then((value) {
      widget.onDismiss();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animation.dispose();
    super.dispose();
  }
}
