
import 'package:flutter/material.dart';

class RotateScreenContainer extends StatefulWidget {
  // You must pass through a child.
  final Widget child;
  final bool rotate;

  const RotateScreenContainer({super.key,
    required this.child,
    this.rotate = false,
  });

  // This is the secret sauce. Write your own 'of' method that will behave
  // Exactly like MediaQuery.of and Theme.of
  // It basically says 'get the data from the widget of this type.
  static RotateScreenState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_InheritedStateContainer>()
    as _InheritedStateContainer).data;
  }

  @override
  RotateScreenState createState() => RotateScreenState();
}

class RotateScreenState extends State<RotateScreenContainer> {
  // Whichever properties you wanna pass around your app as state
  late bool rotate;

  @override
  void initState() {
    rotate = widget.rotate;
    super.initState();
  }
  // You can (and probably will) have methods on your StateContainer
  // These methods are then used through our your app to
  // change state.
  // Using setState() here tells Flutter to repaint all the
  // Widgets in the app that rely on the state you've changed.
  void rotateScreen() {
      rotate = true;
      setState(() {});
  }
  void portraitScreen() {
      rotate = false;
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return  _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final RotateScreenState data;

  const _InheritedStateContainer({
    required this.data,
    required super.child,
  });

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}
