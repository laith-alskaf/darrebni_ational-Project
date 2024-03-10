import 'package:flutter/material.dart';
import 'package:flutter_templete/ui/shared/colors.dart';
import 'package:flutter_templete/ui/shared/custom_widgets/custom_image.dart';
import 'package:flutter_templete/ui/shared/custom_widgets/custom_text.dart';
import 'package:flutter_templete/ui/shared/extensions/custom_sized_box_shared.dart';
import 'package:flutter_templete/ui/shared/utils.dart';

class CustomGridCollege extends StatelessWidget {
  const CustomGridCollege({
    super.key,
    required this.imageName,
    required this.text,
    this.onTap,
    this.isSubbed = false,
  });

  final String imageName;
  final String text;
  final Function? onTap;
  final bool isSubbed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth(40)),
      child: InkWell(
        onTap: isSubbed
            ? () {
                if (onTap != null) onTap!();
              }
            : () {
                showSudscribeDialog();
              },
        child: Container(
          padding: EdgeInsetsDirectional.symmetric(
            vertical: screenWidth(40),
          ),
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(
              width: 2,
              color: isSubbed
                  ? AppColors.darkPurpleColor
                  : AppColors.transparentWhiteColor,
            ),
          )),
          child: Column(
            children: [
              CustomImages(
                networkImage: true,
                imageName: imageName,
                imageSize: screenWidth(6),
              ),
              screenHeight(80).ph,
              CustomText(
                textType: TextStyleType.SMALL,
                text: text,
                textColor: isSubbed
                    ? AppColors.darkPurpleColor
                    : AppColors.darkGreyColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
