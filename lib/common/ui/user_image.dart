import 'package:starter/common/ui/custom_widgets/app_icons/app_network_image.dart';
import 'package:starter/common/utils/ajmal_icons/ajmal_icons.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/extensions/string.dart';
import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  final double size;
  final String? firstLetter;
  final String? imagePath;
  final bool isDeleted;
  const UserImage({super.key, this.size = 30, this.firstLetter, this.imagePath, required this.isDeleted});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColorsSolid4Default,
      ),
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      child: _getUserImageWidget()
    );
  }

  Widget _getUserImageWidget() {
    final showFirstLetter = (imagePath??'').isEmpty && firstLetter != null;
    if(isDeleted){
      return const Icon(
        AjmalIcons.ajmallogo,
        color: AppColors.neutralColors1,
        size: Dimensions.xxLarge,
      );
    }
    else if(showFirstLetter){
      return Text(
        firstLetter??'',
        style: TextStyles.medium(
          color: AppColors.neutralColors1,
          fontSize: Dimensions.xxLarge,
        ),
      );
    }else{
      return AppNetworkImage(
        imageUrl: imagePath ?? '',
        height: size,
        width: size,
        userFullName: firstLetter?.capitalizeFirst,
      );
    }

  }
}
