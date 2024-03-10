import 'package:flutter/material.dart';
import 'package:flutter_templete/ui/shared/colors.dart';
import 'package:flutter_templete/ui/shared/custom_widgets/custom_text.dart';
import 'package:flutter_templete/ui/shared/utils.dart';

class HomeViewCategoryWidget extends StatefulWidget {
  const HomeViewCategoryWidget({
    super.key,
    this.text,
    required this.isSelected,
    required this.onTap,
  });
  final String? text;
  final Function onTap;
  final bool isSelected;

  @override
  State<HomeViewCategoryWidget> createState() => _HomeViewCategoryWidgetState();
}

class _HomeViewCategoryWidgetState extends State<HomeViewCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth(18)),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          height: screenWidth(12),
          decoration: BoxDecoration(
            border: widget.isSelected
                ? Border(
                    bottom: BorderSide(
                      width: 2,
                      color: AppColors.normalCyanColor,
                    ),
                  )
                : null,
            // borderRadius: BorderRadius.circular(20),
          ),
          child: InkWell(
            onTap: () {
              widget.onTap();
            },
            child: CustomText(
              textType: TextStyleType.SUBTITLE,
              text: widget.text ?? 'nothing found',
              textColor: widget.isSelected
                  ? AppColors.normalCyanColor
                  : AppColors.darkGreyColor,
            ),
          ),
        ),
      ),
    );
  }
}
