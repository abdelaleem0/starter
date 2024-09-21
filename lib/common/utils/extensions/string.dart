import 'dart:developer';
import 'dart:io';

import 'package:starter/common/utils/extensions/file.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

extension OnString on String {
  bool get isYoutubeVideo{
    return contains('www.youtube.com/watch') || contains("https://youtu.be/");
  }

  bool isHttpLink() {
    if (startsWith("http")){
      return true;
    } else {
      return false;
    }
  }
}

extension ConvertStringToEnum<T> on String {
  String? get firstLetterOrNull{
    if(isEmpty){
      return null;
    }

    return this[0];
  }
  E? convertToEnum<E>(List<E> enumList){
    for(E e in enumList){
      if((e as Enum).name == this){
        return e;
      }
    }

    return null;
  }

  TextDirection get getTextDirection{
    if(isNotEmpty){
      bool isEnglish = RegExp(r'[a-zA-Z]').hasMatch(this[0]);
      if(!isEnglish){
        return TextDirection.rtl;
      }
    }

    return TextDirection.ltr;
  }

  T toEnum(List<T> enumValues) {
    try {
      return enumValues.firstWhere((element) {
        return element?.toString().split(".").last.toLowerCase() ==
            replaceAll('_', '').toLowerCase();
      });
    } catch (error) {
      log("Please Make Sure That Enum Values Sent in Constructor Is The Same Strings as Text",
          error: error.toString(),
          name: "ERROR WHILE CONVERT STRING TO ENUM CHECK EXTENSION");
      throw Exception(error);
    }
  }

  Size size(TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: this, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  String convertArabicNumbersToEnglish() {
    final number = this;
    return number
        .replaceAll("٠", "0")
        .replaceAll("١", "1")
        .replaceAll("٢", "2")
        .replaceAll("٣", "3")
        .replaceAll("٤", "4")
        .replaceAll("٥", "5")
        .replaceAll("٦", "6")
        .replaceAll("٧", "7")
        .replaceAll("٨", "8")
        .replaceAll("٩", "9");
  }

  String get secureEmail {
    RegExp regex = RegExp(r'(?<=.{3}).(?=[^@]*@)');
    return replaceAll(regex, '*');
  }

  String get capitalizeFirst {
    if (trim().isNotEmpty) {
      return replaceAllMapped(
        RegExp(r"(^\w)"),
            (match) => match.group(0)!.toUpperCase(),
      );
    }
    return this;
  }
  String get capitalizeAll {
    if (trim().isNotEmpty) {
      // Capitalize the first character if it exists
      String capitalizedFirstChar = this[0].toUpperCase() + substring(1);
      return capitalizedFirstChar.replaceAllMapped(
        RegExp(r'(\s\w)'),
            (match) => match.group(0)!.toUpperCase(),
      );
    }
    return this;
  }
}

extension FileSize on String {
  Future<double> get getFileSizeInMb async {
    return await File.fromUri(Uri.parse(this)).sizeInMB;
  }

  Future<double> get getFileSizeInKB async {
    return await File.fromUri(Uri.parse(this)).sizeInKB;
  }

  Future<int> get getFileSizeInByte async {
    return await File.fromUri(Uri.parse(this)).sizeInByte;
  }
}

extension CheckForImage on String {
  bool get isImage {
    final List<String> imageExtensions = [
      'jpg',
      'jpeg',
      'png',
      'gif',
      'webp',
      'bmp',
      'wbmp'
    ];
    final String extension = split('.').last;
    return imageExtensions.contains(extension.toLowerCase());
  }
}

extension CheckForVideo on String {
  bool get isVideo {
    final List<String> videoExtensions = [
      'mov',
      'mp4',
      'avi',
    ];
    final String extension = split('.').last;
    return videoExtensions.contains(extension.toLowerCase());
  }
}

extension MimiType on String {
  MediaType get getMimeType {
    final mime = lookupMimeType(this);
    if (mime != null) {
      final splits = mime.split("/");
      final type = splits.firstOrNull ?? "";
      final subtype = splits.lastOrNull ?? "";
      return MediaType(type, subtype);
    } else {
      return MediaType("", "");
    }
  }
}

extension RemoveSpecificString on String {
  String? removeAt(String specificString) {
    int index = indexOf(specificString);
    if (index != -1) {
      return substring(index + specificString.length);
    } else {
      return null;
    }
  }
}

extension IsNetwork on String {
  bool get isNetwork => startsWith('http') || startsWith('https');
}

extension RemoveWhiteSpaces on String {
  String get removeSpaces => replaceAll(' ', '');

}
String formatLargeNumber(int number) {
  bool isNegative = number < 0;
  int absNumber = number.abs();

  if (absNumber >= 1000000000) {
    int value = absNumber ~/ 100000000;
    double displayValue = value / 10.0;
    return '${isNegative ? '-' : ''} ${displayValue.toStringAsFixed(1)}B';
  } else if (absNumber >= 1000000) {
    int value = absNumber ~/ 100000;
    double displayValue = value / 10.0;
    return '${isNegative ? '-' : ''} ${displayValue.toStringAsFixed(1)}M';
  } else if (absNumber >= 1000) {
    int value = absNumber ~/ 100;
    double displayValue = value / 10.0;
    return '${isNegative ? '-' : ''}${displayValue.toStringAsFixed(1)}k';
  } else {
    return '${isNegative ? '-' : ''} ${absNumber.toString()}';
  }
}


