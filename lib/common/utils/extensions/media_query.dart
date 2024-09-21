import 'package:flutter/cupertino.dart';

const Size _baseSize = Size(375,812);

extension MediaQueryHandler on BuildContext{
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;

  double get scaleWidth => width / _baseSize.width;

  setSp(num size){
    return size * scaleWidth;
  }
}