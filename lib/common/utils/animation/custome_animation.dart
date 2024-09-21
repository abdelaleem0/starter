import 'package:flutter/material.dart';

class SliderAnimationManager extends StatefulWidget {
  final Duration? duration;
  final Curve? curve;
  final Offset? begin;
  final Offset? end;
  final Widget child;
  final AnimationController? controller;
  final void Function(AnimationController controller)? forwardAnimation;

  const SliderAnimationManager(
      {super.key,
      this.duration,
      this.curve,
      this.begin,
      this.end,
      this.controller,
      this.forwardAnimation,
      required this.child});

  @override
  State<SliderAnimationManager> createState() => _SliderAnimationManagerState();
}

class _SliderAnimationManagerState extends State<SliderAnimationManager>
    with TickerProviderStateMixin {
  late final Animation<Offset> _slideAnimation;
  late final AnimationController _slideController;
  final _constSlideDuration = const Duration(milliseconds: 1800);

  @override
  void initState() {
    _initializeAnimation();
    _forwardAnimation();

    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _slideController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: widget.child,
    );
  }

  void _initializeController() {
    if (widget.controller == null) {
      _slideController = AnimationController(
        vsync: this,
        duration: widget.duration ?? _constSlideDuration,
      );
    } else {
      _slideController = widget.controller!;
    }
  }

  void _initializeAnimation() {
    _initializeController();
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: widget.curve ?? Curves.fastLinearToSlowEaseIn,
    ));
  }

  void _forwardAnimation() {
    _slideController.forward().then((value) {
      if (widget.forwardAnimation != null) {
        widget.forwardAnimation!(_slideController);
      }
    });
  }
}

class FadeAnimationManager extends StatefulWidget {
  final Duration? duration;
  final double? begin;
  final double? end;
  final Widget child;
  final AnimationController? controller;
  final void Function(AnimationController controller)? forwardAnimation;

  const FadeAnimationManager(
      {super.key,
      this.duration,
      this.begin,
      this.end,
      this.controller,
      this.forwardAnimation,
      required this.child});

  @override
  State<FadeAnimationManager> createState() => _FadeAnimationManagerState();
}

class _FadeAnimationManagerState extends State<FadeAnimationManager>
    with TickerProviderStateMixin {
  late final Animation<double> _fadeAnimation;
  late final AnimationController _fadeController;
  final _constFadeDuration = const Duration(milliseconds: 900);

  @override
  void initState() {
    print("GWRGWGWwrg");
    _initializeAnimation();
    _forwardAnimation();

    super.initState();
  }

  @override
  void dispose() {
    print("dispose");
    if (widget.controller == null) {
      _fadeController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: widget.child,
    );
  }

  void _initializeController() {
    if (widget.controller == null) {
      _fadeController = AnimationController(
        vsync: this,
        duration: widget.duration ?? _constFadeDuration,
      );
    } else {
      _fadeController = widget.controller!;
    }
  }

  void _initializeAnimation() {
    _initializeController();
    _fadeAnimation = Tween<double>(
      begin: widget.begin ?? 0.3,
      end: widget.end ?? 1,
    ).animate(
      _fadeController,
    );
  }

  void _forwardAnimation() {
    _fadeController.forward().then((value) {
      if (widget.forwardAnimation != null) {
        widget.forwardAnimation!(_fadeController);
      }
    });
  }
}

class ScaleAnimationManager extends StatefulWidget {
  final Duration? duration;
  final double? begin;
  final double? end;
  final Widget child;
  final AnimationController? controller;
  final Curve? curve;
  final void Function(AnimationController controller)? forwardAnimation;

  const ScaleAnimationManager(
      {super.key,
      this.duration,
      this.begin,
      this.end,
      this.curve,
      this.controller,
      this.forwardAnimation,
      required this.child});

  @override
  State<ScaleAnimationManager> createState() => _ScaleAnimationManagerState();
}

class _ScaleAnimationManagerState extends State<ScaleAnimationManager>
    with TickerProviderStateMixin {
  late final Animation<double> _scaleAnimation;
  late final AnimationController _scaleController;
  final _constScaleDuration = const Duration(milliseconds: 800);

  @override
  void initState() {
    _initializeAnimation();
    _forwardAnimation();

    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _scaleController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: widget.child,
    );
  }

  void _initializeController() {
    if (widget.controller == null) {
      _scaleController = AnimationController(
        vsync: this,
        duration: widget.duration ?? _constScaleDuration,
      );
    } else {
      _scaleController = widget.controller!;
    }
  }

  void _initializeAnimation() {
    _initializeController();
    _scaleAnimation = Tween<double>(
      begin: widget.begin ?? 0.0,
      end: widget.end ?? 1,
    ).animate(
      _scaleController,
    );
    // _scaleAnimation = CurvedAnimation(
    //     parent: _scaleController, curve: widget.curve ?? Curves.ease);
  }

  void _forwardAnimation() {
    _scaleController.forward().then((value) {
      if (widget.forwardAnimation != null) {
        widget.forwardAnimation!(_scaleController);
      }
    });
  }
}
