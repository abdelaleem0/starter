import 'package:starter/common/ui/custom_widgets/app_toast/toast.dart';
import 'package:flutter/material.dart';

class PurchasePageViewController {
  static final PurchasePageViewController instance =
      PurchasePageViewController._();

  PurchasePageViewController._();

  //variables
  ValueNotifier<bool> _showLoadingNotifier = ValueNotifier(false);

  //functions
  _init(){
    // ignore: invalid_use_of_protected_member
    if(!_showLoadingNotifier.hasListeners){
      _showLoadingNotifier = ValueNotifier(false);
    }
  }

  void showPurchasePage(BuildContext context){
    ModalRoute.of(context)?.addScopedWillPopCallback(() async{
      return !_showLoadingNotifier.value;
    });

    Future.delayed(const Duration(seconds: 1) , () {
      AppToast().dismissToast();
    },);
    _showLoadingNotifier.value = true;
  }

  void removePurchasePage() {
    _showLoadingNotifier.value = false;
  }
}

class PurchaseController extends StatefulWidget {
  final Widget child;

  const PurchaseController({
    super.key,
    required this.child,
  });

  @override
  State<PurchaseController> createState() => _PurchaseControllerState();
}


class _PurchaseControllerState extends State<PurchaseController>  {


  @override
  void initState() {
    PurchasePageViewController.instance._init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable:
            PurchasePageViewController.instance._showLoadingNotifier,
        builder: (context, showPurchasePage, children) {
          return Stack(
            children: [
              children!,
              if (showPurchasePage)...[
              ]
            ],
          );
        },
        child: widget.child);
  }
}


