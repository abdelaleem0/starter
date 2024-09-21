import 'package:flutter/material.dart';

extension Separators on double{
  Widget get hSeparator => SizedBox(height: this);
  Widget get wSeparator => SizedBox(width: this);
}