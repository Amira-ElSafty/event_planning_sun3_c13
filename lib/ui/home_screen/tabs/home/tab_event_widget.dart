import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';
import 'package:flutter/material.dart';

class TabEventWidget extends StatelessWidget {
  bool isSelected ;
  String eventName ;
  TabEventWidget ({required this.isSelected,required this.eventName});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height ;
    var width = MediaQuery.of(context).size.width ;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height*0.005
      ),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.whiteColor : AppColors.transparentColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.whiteColor,
          width: 2
        )
      ),
      child: Text(eventName,
      style: isSelected ? AppStyles.medium16Primary : AppStyles.medium16White,),
    );
  }
}
