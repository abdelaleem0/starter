import 'package:starter/common/ui/custom_widgets/app_icons/app_icon.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AppNetworkImage extends StatefulWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;
  final String? errorAssetImage;
  final Color? errorBgColor;
  final String? userFullName;

  const AppNetworkImage(
      {super.key,
        required this.imageUrl,
        this.height,
        this.width,
        this.errorAssetImage,
        this.fit = BoxFit.cover,
        this.errorBgColor,
        this.userFullName,
      });

  @override
  State<AppNetworkImage> createState() => _AppNetworkImageState();
}

class _AppNetworkImageState extends State<AppNetworkImage> {
  int widgetKey = 0;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: ValueKey(widgetKey),
      imageUrl: widget.imageUrl,
      fit: widget.fit,
      height: widget.height,
      width: widget.width,
      errorWidget: (context, error, stackTrace) {
        if(widget.userFullName != null || widget.errorAssetImage != null){
          return _BuildErrorWidget(
              errorAssetImage: widget.errorAssetImage,
              width: widget.width,
              height: widget.height,
              bgColor: widget.errorBgColor,
              userFullName: widget.userFullName
          );
        }

        return GestureDetector(
          onTap: (){
            setState(() {
              widgetKey++;
            });
          },
          child: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Icon(Icons.refresh)
          ),
        );
      },
      progressIndicatorBuilder: (context, child, loadingProgress) {
        return Center(
          child: CircularProgressIndicator(
            value:loadingProgress.downloaded.toDouble(),
            color: AppColors.primaryColorsSolid4Default,
          ),
        );
      },
    );
  }
}

class _BuildErrorWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final String? errorAssetImage;
  final Color? bgColor;
  final String? userFullName;

  const _BuildErrorWidget(
      {this.height, this.width, this.errorAssetImage,this.bgColor, this.userFullName});

  @override
  Widget build(BuildContext context) {
    if(userFullName != null){
      return ColoredBox(
        color: bgColor ?? AppColors.primaryColorsSolid4Default,
        child: Center(
          child: Text(
            _getFirstAndLastCharacters(userFullName!),
            style: TextStyles.medium(
                fontSize: Dimensions.xxLarge,
                color: AppColors.neutral_0
            ),
          ),
        ),
      );
    }

    final errorImageWidth = width == null ? null : width!/2;
    final errorImageHeight = height == null ? null : height!/2;

    return ColoredBox(
      color: bgColor ?? AppColors.neutral_0,
      child: ( errorAssetImage != null) ?

      Center(
        child: AppIcons(
          fit: BoxFit.contain,
          width: errorImageWidth,
          height: errorImageHeight,
          imagePath: errorAssetImage!,
        ),
      ) : SizedBox(
        width: errorImageWidth,
        height: errorImageHeight,
        child: const Icon(
          Iconsax.gallery_slash,
          size: IconDimensions.large,
        ),
      ),
    );
  }

  String _getFirstAndLastCharacters(String userFullName){
    List<String> names = userFullName.trim().split(' ');

    if(names.isNotEmpty){
      String firstName = names[0];
      String secondName = names.length > 1 ? names[1] : '';

      String firstInitial = firstName.isNotEmpty ? firstName[0] : '';
      String secondNameInitial = secondName.isNotEmpty ? secondName[0] : '';

      return (firstInitial + secondNameInitial).toUpperCase();
    }

    return '';
  }
}