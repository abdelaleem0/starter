import 'package:flutter/material.dart';

/// xSmall = 6;
///
/// small = 8;
///
/// normal = 10;
///
/// large = 12;
///
/// xLarge = 14 ;
///
/// xxLarge =  16;
///
/// xxxLarge = 18;
///
/// xxxxLarge = 20;
///
/// xxxxxLarge = 22;
///

/// smallDisplay = 24;
///
/// mediumDisplay = 30;
///
/// largeDisplay = 48;
class Dimensions {
  Dimensions._();

  static const double xSmall = 6;
  static const double small = 8;
  static const double normal = 10;
  static const double large = 12;
  static const double xLarge = 14 ;
  static const double xxLarge =  16;
  static const double xxxLarge = 18;
  static const double xxxxLarge = 20;
  static const double xxxxxLarge = 22;

  static const double smallDisplay = 24;
  static const double mediumDisplay = 30;
  static const double largeDisplay = 48;

  static const double buttonHeight = 56;
  static const double buttonMediumHeight =  48;
  static const double buttonMinHeight = 34;

  static const double pickerItemHeight = 30;

  static const double toolbarHeight = 40;

  static const double buttonCornerRadius = 24;


  static const double spaceBetweenTextFields = 20;

  static const double xSmallRadius = 2.0;
  static const double smallRadius = 4.0;
  static const double regularRadius = 8.0;
  static const double mediumRadius = 12.0;
  static const double largeRadius = 16.0;
  static const double xLargeRadius = 24.0;
  static const double xxLargeRadius = 40.0;


  static double get buttonMiniHeight =>  40 ;
  static const double actionButtonHeight = 100;
  static const double textHeight = 36;

  static double get leadingWidth =>
      IconDimensions.medium + pageSmallMargins.right;



  static EdgeInsets pageMargins = const EdgeInsets.symmetric(
      horizontal: PaddingDimensions.large, vertical: PaddingDimensions.large);
  static EdgeInsets pageSmallMargins =
      const EdgeInsets.symmetric(horizontal: PaddingDimensions.large);
  static EdgeInsets pageSmallVerticalMargins =
  const EdgeInsets.symmetric(horizontal: PaddingDimensions.large,vertical: PaddingDimensions.normal);

  static EdgeInsets get formMargins =>
      const EdgeInsets.symmetric(horizontal:  32 );



  static double get addIconSize =>  28;
  static double get bottomAppBarSize => 100;
}

class IconDimensions {
  IconDimensions._();

  static const double xxSmall = 14;
  static const double xSmall = 16;
  static const double small = 18;
  static const double normal = 20;
  static const double medium =  24;
  static const double large =  32;
  static const double xLarge =  40;
  static const double xxLarge = 50;
}

/// small = 4 ;
///
/// normal =  8;
///
/// medium = 12;
///
/// large = 16;
///
/// xLarge = 20;
///
/// xxLarge = 24;
///
/// xxxLarge = 28;
///
/// x4Large = 32;
///
/// x5Large = 40;
///
/// x6Large = 48;
///
/// x7Large = 90;
///
class PaddingDimensions {
  PaddingDimensions._();
  static const double small = 4 ;
  static const double normal =  8;
  static const double medium = 12;
  static const double large = 16;
  static const double xLarge = 20;
  static const double xxLarge = 24;
  static const double xxxLarge = 28;
  static const double x4Large = 32;
  static const double x5Large = 40;
  static const double x6Large = 48;
  static const double x7Large = 90;
}