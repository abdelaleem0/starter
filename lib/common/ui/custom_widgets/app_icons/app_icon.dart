import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons extends StatelessWidget {
  const AppIcons(
      {super.key,
      required this.imagePath,
      this.color,
      this.width,
      this.height,
      this.size,
        this.fit});

  final String imagePath;
  final Color? color;
  final double? width;
  final double? height;
  final double? size;
  final BoxFit? fit;

  static SvgPicture getSvgIcon(
      {required String imagePath,
      double? width,
      double? height,
      Color? color,
        BoxFit fit = BoxFit.contain,
      double? size}) {
    return SvgPicture.asset(
      imagePath,
      fit: fit,
      width: size ?? width,
      height: size ?? height,
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      placeholderBuilder: (BuildContext context) => Container(
          width: size ?? 25,
          height: size ?? 25,
          decoration: const BoxDecoration(
              color: AppColors.appBackgroundColor, shape: BoxShape.circle),
          child: const CircularProgressIndicator()),
    );
  }

  static Image getImageIcon(
      {required String imagePath,
      double? width,
      double? height,
        BoxFit? boxFit,
      Color? color}) {
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      color: color,
      fit:boxFit,
    );
  }

  static Image getBottomNavigationImage({required String imagePath}) {
    return getImageIcon(imagePath: imagePath, width: 30, height: 30);
  }

  @override
  Widget build(BuildContext context) {
    if (imagePath.endsWith(".svg")) {
      return getSvgIcon(
          imagePath: imagePath,
          width: width,
          height: height,
          size: size,
          fit: fit ?? BoxFit.contain,
          color: color);
    } else {
      return getImageIcon(
          imagePath: imagePath, width: width, height: height, color: color , boxFit: fit);
    }
  }
}
