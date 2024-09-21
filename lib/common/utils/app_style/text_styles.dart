import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle regular(
          {Color color = Colors.black,
          double fontSize = 14.0,
            TextOverflow? textOverFlow,
          double? height,
          }) =>
      TextStyle(
          height: height,
          color: color,
          fontFamily: 'NotoSans',
          overflow: textOverFlow ?? TextOverflow.visible,
          fontWeight: FontWeight.w400,
          fontSize: fontSize,);

  static TextStyle regularLineThrough(
      {Color color = Colors.black,
        double fontSize = 14.0,
        TextOverflow? textOverFlow,
        double? height}) =>
      TextStyle(
          height: height,
          color: color,
          fontFamily: 'NotoSans',
          overflow: textOverFlow ?? TextOverflow.visible,
          fontWeight: FontWeight.w400,
          fontSize: fontSize,decoration: TextDecoration.lineThrough);
  static TextStyle light(
      {Color color = Colors.black,
        double fontSize = 14.0,
        double? height}) =>
      TextStyle(
          height: height,
          color: color,
          fontFamily: 'NotoSans',
          fontWeight: FontWeight.w300,
          fontSize: fontSize);

  static TextStyle bold({
    Color color = Colors.black,
    double fontSize = 14.0,
    double? height,
  }) =>
      TextStyle(
          height: height,
          color: color,
          fontFamily: 'NotoSans',
          fontWeight: FontWeight.w700,
          fontSize: fontSize);

  static TextStyle boldUnderlined(
          {Color color = Colors.black, double fontSize = 14.0}) =>
      TextStyle(
          color: color,
          fontFamily: 'NotoSans',
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
          decoration: TextDecoration.underline);

  static TextStyle regularUnderlined({
    Color color = Colors.black,
    double fontSize = 14.0,
  }) =>
      TextStyle(
          color: color,
          fontFamily: 'NotoSans',
          fontWeight: FontWeight.w400,
          fontSize: fontSize,
          decoration: TextDecoration.underline);

  static TextStyle medium(
          {Color color = Colors.black,
          double fontSize = 14.0,
            TextOverflow? textOverFlow,
          double? height}) =>
      TextStyle(
          height: height,
          color: color,
          overflow: textOverFlow ?? TextOverflow.visible,
          fontFamily: 'NotoSans',
          fontWeight: FontWeight.w500,
          fontSize: fontSize);
  static TextStyle mediumUnderlined(
          {Color color = Colors.black, double fontSize = 14.0}) =>
      TextStyle(
        color: color,
        fontFamily: 'NotoSans',
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
        decoration: TextDecoration.underline,
      );

  static TextStyle semiBold(
          {Color color = Colors.black,
          double fontSize = 14.0,
          double? height}) =>
      TextStyle(
          height: height,
          color: color,
          fontFamily: 'NotoSans',
          fontWeight: FontWeight.w600,
          fontSize: fontSize);

  static TextStyle semiBoldLineThrough(
      {Color color = Colors.black,
        double fontSize = 14.0,
        double? height}) =>
      TextStyle(
          height: height,
          color: color,
          fontFamily: 'NotoSans',
          fontWeight: FontWeight.w600,
          fontSize: fontSize,decoration:TextDecoration.lineThrough );

  static TextStyle thin({Color color = Colors.black, double fontSize = 14.0 , double height =  1}) =>
      TextStyle(
          color: color,
          fontFamily: 'NotoSans',
          fontWeight: FontWeight.w100,
          height: height ,
          fontSize: fontSize);
}
